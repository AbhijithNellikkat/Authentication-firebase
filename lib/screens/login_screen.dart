import 'dart:developer';

import 'package:authentication_firebase_app/main.dart';
import 'package:authentication_firebase_app/utils/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.onClickedSignUp});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final VoidCallback onClickedSignUp;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      final isvalid = formKey.currentState!.validate();
      if (!isvalid) return;

      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        FocusManager.instance.primaryFocus?.unfocus();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        log('$e');

        Utils.showSnackBar('${e.message}');
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter valid email'
                              : null,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email), labelText: 'Email'),
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter min. 6 characters'
                          : null,
                      obscureText: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined),
                          labelText: 'Password'),
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: signIn,
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                        child: Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 40),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        text: 'No account ? ',
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = onClickedSignUp,
                            text: 'Sign Up',
                            style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
