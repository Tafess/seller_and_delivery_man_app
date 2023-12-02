import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
        //prefixText: controller == _contactNumber ? '+251' : '',
      ),
      onChanged: ((value) {
        if (controller == '_businessName') {
          setState(() {
            //       bName = value;
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Seller Registration'),
          backgroundColor: Colors.black26,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
        ));
  }
}
