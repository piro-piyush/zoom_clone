import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/screens/home_screen.dart';
import 'package:zoom_clone/screens/login_screen.dart';
import 'package:zoom_clone/screens/video_call_screen.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyColors.backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/video-call': (context) => VideoCallScreen(),
      },
      home: StreamBuilder(
        stream: AuthMethods().authStream,
        builder: (context, snapshot) {
          // Check for connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          // Check if there's user data (i.e. the user is logged in)
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // If no data (i.e. the user is not logged in), show login screen
          return const LoginScreen();
        },
      ),
    );
  }
}
