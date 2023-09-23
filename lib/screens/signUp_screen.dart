import 'dart:developer';

import 'package:authentication_firebase_app/widgets/textFormField_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key, required this.onClickedSignUp});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final VoidCallback onClickedSignUp;
  @override
  Widget build(BuildContext context) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormFieldWidget(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                    controller: _passwordController,
                    hintText: 'password',
                    obscureText: true,
                    prefixIcon: Icons.password_outlined,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      signUp(context);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                      child: Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      text: 'Already have an account?',
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = onClickedSignUp,
                          text: 'Login',
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
    );
  }

  Future signUp(context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      log('$e');
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
