import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers/constants/primary_button.dart';
import 'package:sellers/constants/top_titles.dart';

class AddressTab extends StatefulWidget {
  const AddressTab({super.key});

  @override
  State<AddressTab> createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  String? address;

  String? _idCardUrl;
  String? _logoUrl;
  XFile? _logo;

  XFile? _idCard;

  final ImagePicker _picker = ImagePicker();

  final TextEditingController zone = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController woreda = TextEditingController();
  final TextEditingController kebele = TextEditingController();

  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Widget customSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }

  Widget _formField({
    TextEditingController? controller,
    String? hint,
    TextInputType? type,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                  children: [
                    _idCard == null
                        ? Container(
                            height: 240,
                            color: Colors.blue.shade400,
                            child: TextButton(
                              onPressed: () {
                                _pickImage().then((value) {
                                  setState(() {
                                    _idCard = value;
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
                                    _idCard = value;
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
                                image: _idCard == null
                                    ? null
                                    : DecorationImage(
                                        opacity: 130,
                                        image: FileImage(File(_idCard!.path)),
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
                                    _logo = value;
                                  });
                                });
                              },
                              child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  child: _logo == null
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
                                            child:
                                                Image.file(File(_logo!.path)),
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
                hint: 'Zone address',
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
                hint: 'Wereda',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter wereda name';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
              _formField(
                controller: kebele,
                hint: 'Kebele',
                type: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter kebele';
                  }
                  return null;
                },
              ),
              customSizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
