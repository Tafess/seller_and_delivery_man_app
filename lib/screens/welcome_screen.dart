import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/screens/home_page.dart';
import 'package:sellers/screens/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PrimaryButton(
              onPressed: () {
                appProvider.isSignedIn == true
                    ? Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const HomePage(),
                        ),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const LoginScreen(),
                        ),
                      );
              },
              title: 'Get Started'),
        ],
      )),
    );
  }
}
