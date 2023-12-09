import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/constants/top_titles.dart';
import 'package:sellers/screens/login.dart';
import 'package:sellers/screens/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/belkis3.jpg',
                  scale: 8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.facebook,
                      size: 35,
                      color: Colors.blue,
                    ),
                  ),
                  // CupertinoButton(
                  //   onPressed: () {},
                  //   child: Image.asset(
                  //     AssetImages.instance.googleLogo,
                  //     scale: 80,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                title: 'Sign In',
                onPressed: () {
                  Routes.instance.push(widget: const Login(), context: context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                title: 'Sign Up',
                onPressed: () {
                  Routes.instance
                      .push(widget: const SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
