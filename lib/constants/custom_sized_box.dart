import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({super.key});

  @override
  Widget build(BuildContext context) {
    Widget customSizedBox({double? height, double? width}) {
      return SizedBox(
        height: height ?? 0,
        width: width ?? 0,
      );
    }

    return customSizedBox();
  }
}
