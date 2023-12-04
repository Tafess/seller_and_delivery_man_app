import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/constants.dart';
import 'package:sellers/constants/routes.dart';
import 'package:sellers/controllers/firebase_auth_helper.dart';
import 'package:sellers/controllers/firebase_firestore_helper.dart';
import 'package:sellers/controllers/firebase_storage_helper.dart';
import 'package:sellers/provider/app_provider.dart';
import 'package:sellers/screens/home_page.dart';
import 'package:sellers/screens/registration/address_tab.dart';
import 'package:sellers/screens/registration/general_tab.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuthHelper authHelper = FirebaseAuthHelper();
  static FirebaseStorageHelper _storageHelper = FirebaseStorageHelper();
  String? countryValue;
  String? stateValue;
  String? cityValue;
  String? address;

  String? idCardUrl;
  String? profilePhotoUrl;
  XFile? profilePhoto;

  XFile? idCard;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();
  final TextEditingController zone = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController woreda = TextEditingController();
  final TextEditingController kebele = TextEditingController();
  Widget _formField({
    TextEditingController? controller,
    String? label,
    TextInputType? type,
    String? Function(String?)? validator,
  }) {
    {
      return TextFormField(
        controller: controller,
        keyboardType: type,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixText: controller == 'phoneNumber' ? '+251' : '',
        ),
        onChanged: ((value) {
          if (controller == 'firstName') {
            setState(() {
              //  bName = value;
            });
          }
        }),
      );
    }
  }

  Widget customSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }

  // void takePicture() async {
  //   XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (value != null) {
  //     setState(() {
  //       _idCard = File(value.path);
  //     });
  //   }
  // }

  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    FirebaseAuthHelper authHelper = Provider.of<FirebaseAuthHelper>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Seller Registration'),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                  children: [
                    idCard == null
                        ? Container(
                            height: 240,
                            color: Colors.blue.shade400,
                            child: TextButton(
                              onPressed: () {
                                _pickImage().then((value) {
                                  setState(() {
                                    idCard = value;
                                  });
                                });
                              },
                              child: const Center(
                                child: Text(
                                  'Tap to add Id card Image',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              _pickImage().then((value) {
                                try {
                                  setState(() {
                                    idCard = value;
                                  });
                                } catch (e) {
                                  print('Error loading image: $e');
                                }
                              });
                            },
                            child: Container(
                              height: 240,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                image: idCard == null
                                    ? null
                                    : DecorationImage(
                                        opacity: 130,
                                        image: FileImage(File(idCard!.path)),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 80,
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.logout_sharp),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _pickImage().then((value) {
                                  setState(() {
                                    profilePhoto = value;
                                  });
                                });
                              },
                              child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  child: profilePhoto == null
                                      ? const SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: Center(
                                            child: Text(
                                              '+',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.file(
                                                File(profilePhoto!.path)),
                                          ),
                                        )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              zone.text == null ? '' : zone.text!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              customSizedBox(height: 20),
              _formField(
                controller: firstName,
                label: 'First name',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter first name';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: middleName,
                label: 'Second name',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter second name';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: lastName,
                label: 'Last  name',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter last name';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: email,
                label: 'Email ',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email address';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: phoneNumber,
                label: 'Phone number',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter phone number';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: password,
                label: 'Password',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: conformPassword,
                label: 'Conform Password',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter conform password ';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 20),
              CSCPicker(
                showStates: true,

                showCities: true,

                flagState: CountryFlag.DISABLE,

                dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

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
              customSizedBox(height: 12),
              _formField(
                controller: zone,
                label: 'Zone address',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter zone name';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: woreda,
                label: 'Wereda',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter woreda address';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: kebele,
                label: 'Kebele',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter kebele address';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              customSizedBox(height: 30),
            ],
          ),
        ),

        //const TabBarView(
        //   children: [
        //     GeneralTab(),
        //     AddressTab(),
        //   ],

        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      saveToDatabase();
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
              ],
            ),
          )
        ],
      ),
    );
  }

  saveToDatabase() {
    if (idCard == null) {
      showMessage('Plessa add id card image');
      return;
    }
    if (profilePhoto == null) {
      showMessage('Plessa add profile image');
      return;
    }
    if (password.text != conformPassword.text)
      showMessage('Password does not match');
    if (_formKey.currentState!.validate()) {
      if (countryValue == null || stateValue == null || cityValue == null) {
        showMessage('Select adress fields completely');
        return;
      }
      EasyLoading.show(status: 'Please Wait...');
      _storageHelper
          .uploadImage(idCard, 'sellers/${_storageHelper.user!.uid}/idCard.jpg')
          .then((String? url) {
        if (url != null) {
          setState(() {
            idCardUrl = url;
          });
        }
      }).then((value) {
        _storageHelper
            .uploadImage(
                profilePhoto, 'sellers/${_storageHelper.user!.uid}/profile.jpg')
            .then((url) {
          setState(() {
            profilePhotoUrl = url;
          });
        }).then((value) {
          authHelper
              .signUp(
            firstName.text,
            middleName.text,
            lastName.text,
            email.text,
            password.text,
            phoneNumber.text,
            countryValue!,
            stateValue!,
            cityValue!,
            zone.text,
            woreda.text,
            kebele.text,
            idCard,
            profilePhoto,
            context,
          )
              .then((value) {
            Routes.instance
                .pushAndRemoveUntil(widget: HomePage(), context: context);

            EasyLoading.dismiss();

            showMessage('Successfully Registerd');
            //  bool alreadyNavigated = true;
          });
        });
      });
    }
  }
}
