import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _userCollection = ('Users');

  User get user => _auth.currentUser!;

  Stream<User?> get authStream => _auth.authStateChanges();

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _db.collection(_userCollection).doc(user.uid).set({
            'userName': user.displayName,
            'uid': user.uid,
            'photoUrl': user.photoURL,
            'email': user.email,
            'phoneNumber': user.phoneNumber,
            'createdAt': DateTime.now(),
          });
        }
        res = true;
      }
      return res;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils.showErrorSnackBar(context, e.message!);
      }
      return false;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      if (context.mounted) {
        Navigator.pushNamed(context, '/login');
        Utils.showSuccessSnackBar(context, "Logged Out Successfully");
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Utils.showErrorSnackBar(context, e.message!);
      }
      return;
    }
  }
}
