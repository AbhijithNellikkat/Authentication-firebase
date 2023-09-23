import 'dart:developer';

import 'package:authentication_firebase_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/textFormField_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.onClickedSignUp});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final VoidCallback onClickedSignUp;

  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        log('$e');
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
    );
  }
}
