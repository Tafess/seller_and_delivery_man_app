import 'package:flutter/material.dart';

class GeneralTab extends StatefulWidget {
  const GeneralTab({super.key});

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController secondName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();

  Widget _formField({
    TextEditingController? controller,
    String? label,
    TextInputType? type,
    String? Function(String?)? validator,
  }) {
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

  Widget customSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
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
              controller: secondName,
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
            customSizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
