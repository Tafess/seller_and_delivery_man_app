// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Image.asset('assets/image.png'),
                ),
                SizedBox(height: 12),
                Text('Login '),
                SizedBox(height: 12),
                FittedBox(
                    child: Text('Welcom add your phone number to continou'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
