// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/screens/home_page.dart';
import 'package:sellers/screens/registration_screen.dart';

class AutpScreen extends StatefulWidget {
  final String VerificationId;
  const AutpScreen({super.key, required this.VerificationId});

  @override
  State<AutpScreen> createState() => _AutpScreenState();
}

class _AutpScreenState extends State<AutpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isloading = Provider.of<AppProvider>(context, listen: true).isLoading;
    return Scaffold(
        body: SafeArea(
      child: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      padding: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade300,
                      ),
                      child: Image.asset('assets/image.png'),
                    ),
                    SizedBox(height: 12),
                    Text('Verification '),
                    SizedBox(height: 12),
                    FittedBox(
                      child: Text(
                        'Enter the otp sent your phone number',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Pinput(
                      length: 6,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        height: 50,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      onCompleted: (value) {
                        setState(() {
                          otpCode = value;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    PrimaryButton(
                        onPressed: () {
                          if (otpCode != null) {
                            verfyOtp(context, otpCode!);
                          } else {
                            showMessage('Enter verification code');
                          }
                        },
                        title: 'Verify'),
                    SizedBox(height: 30),
                    Text(
                      'Don`t recieve any code ',
                      style:
                          TextStyle(color: Colors.grey.shade900, fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Resent code ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ));
  }

  void verfyOtp(BuildContext context, String userOtp) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.verifyOtp(
        verificationId: widget.VerificationId,
        userOtp: userOtp,
        onSuccess: () {
          // check whether user exist or not
          appProvider.checkExistingUser().then((value) async {
            if (value == true) {
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  (route) => false);
            }
          });
        });
  }
}
