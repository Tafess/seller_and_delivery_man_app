// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/constants/top_titles.dart';
import 'package:sellers/controllers/firebase_auth_helper.dart';
import 'package:sellers/screens/login.dart';
import 'package:sellers/widgets/bottom_bar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool isShowPassword = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController conformPassword = TextEditingController();
  TextEditingController zone = TextEditingController();
  TextEditingController woreda = TextEditingController();
  TextEditingController kebele = TextEditingController();

  String? countryValue;
  String? stateValue;

  String? cityValue;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        // appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Icon(Icons.arrow_back),

                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: firstName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'First name ',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter first name';
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: middleName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Middle Name ',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter middle name';
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: lastName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Last name ',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter last name';
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),

                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'E-mail ',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter email address';
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter phone number';
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: password,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      child: Icon(
                        Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter password ';
                    }
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: conformPassword,
                  obscureText: isShowPassword,
                  decoration: InputDecoration(
                    hintText: 'Conform password',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    suffixIcon: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      child: Icon(
                        Icons.visibility,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CSCPicker(
                  showStates: true,

                  showCities: true,

                  flagState: CountryFlag.DISABLE,

                  dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  ///placeholders for dropdown search field
                  countrySearchPlaceholder: "Country",
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",

                  ///labels for dropdown
                  countryDropdownLabel: "Country",
                  stateDropdownLabel: "Region",
                  cityDropdownLabel: "City",

                  ///Default Country
                  defaultCountry: CscCountry.Ethiopia,

                  selectedItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  dropdownHeadingStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  dropdownItemStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  dropdownDialogRadius: 10.0,

                  searchBarRadius: 10.0,

                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },

                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },

                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: zone,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Zone Address ',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: woreda,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Woreda address ',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: kebele,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Kebele Address ',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool isValidate = signValidation(
                          email.text,
                          password.text,
                          lastName.text,
                          phone.text,
                        );
                        if (isValidate) {
                          bool islogined =
                              await FirebaseAuthHelper.instance.signUp(
                            firstName.text,
                            middleName.text,
                            lastName.text,
                            phone.text,
                            email.text,
                            password.text,
                            countryValue!,
                            stateValue!,
                            cityValue!,
                            zone.text,
                            woreda.text,
                            kebele.text,
                            context,
                          );
                          if (islogined) {
                            Routes.instance.pushAndRemoveUntil(
                                widget: CustomBottomBar(), context: context);
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade400),
                      // No need to set width here
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text('OR'),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Routes.instance.push(widget: Login(), context: context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green.shade400),
                      // No need to set width here
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
