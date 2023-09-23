import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.keyboardType,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    required this.validator,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final String Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
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
