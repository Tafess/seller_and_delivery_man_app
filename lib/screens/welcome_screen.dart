import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/screens/home_page.dart';
import 'package:sellers/screens/login.dart';
import 'package:sellers/screens/registration/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the user is signed in
    bool isSignedIn = FirebaseAuth.instance.currentUser != null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryButton(
              onPressed: () {
                if (isSignedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoginScreen(),
                    ),
                  );
                }
              },
              title: 'Get Started',
            ),
          ],
        ),
      ),
    );
  }
}
