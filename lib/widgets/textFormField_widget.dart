import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      this.controller,
      this.keyboardType,
      required this.hintText,
      required this.prefixIcon,
      required this.obscureText});

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
