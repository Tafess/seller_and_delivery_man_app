// ignore_for_file: prefer_const_constructors

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/provider/app_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: '251',
    countryCode: 'ET',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Ethiopia',
    example: 'Ethiopia',
    displayName: 'Ethiopia',
    displayNameNoCountryCode: 'ET',
    e164Key: '',
  );

  Widget _verticalDivider() {
    return VerticalDivider(
      color: Colors.grey,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    _phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneController.text.length));
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
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade300,
                  ),
                  child: Image.asset('assets/image.png'),
                ),
                SizedBox(height: 12),
                Text('Login '),
                SizedBox(height: 12),
                FittedBox(
                  child: Text(
                    'Welcom add your phone number to continou',
                    textAlign: TextAlign.center,
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    setState(() {
                      _phoneController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: 500,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 5, 5),
                            child: Text(
                              '${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: _phoneController.text.length > 9
                          ? Container(
                              height: 20,
                              width: 20,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : null),
                ),
                SizedBox(height: 20),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: PrimaryButton(
                        onPressed: () {
                          sendPhoneNumber();
                        },
                        title: 'Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    String phoneNumber = _phoneController.text.trim();

    appProvider.signInWithPhone(
        context, '+${selectedCountry.phoneCode}$phoneNumber');
  }
}
