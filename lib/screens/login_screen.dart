import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/utils/images.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Start or join a meeting",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Image.asset(MyImages.onboarding),
          ),
          CustomButton(
            onTap: () async {
              bool res = await _authMethods.signInWithGoogle(context);
              if (res) {
                if (context.mounted) {
                  Navigator.pushNamed(context, '/home');
                  Utils.showSuccessSnackBar(context, "Logged In Successfully");
                }
              }
            },
            text: "Google Sign In",
          ),
        ],
      ),
    );
  }
}
