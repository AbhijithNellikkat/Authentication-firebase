// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:authentication_firebase_app/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future resetPassword() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());

        Utils.showSnackBar('Password Reset Email send');
        Navigator.of(context).popUntil((route) => route.isFirst);
      } on FirebaseAuthException catch (e) {
        log('$e');

        Utils.showSnackBar('${e.message}');
        Navigator.of(context).pop();
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reset password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Recevie an email to reset your password'),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter valid email'
                            : null,
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 30),
                  OutlinedButton(
                      onPressed: resetPassword,
                      child: const Text('Reset password'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
