import 'package:authentication_firebase_app/screens/login_screen.dart';
import 'package:authentication_firebase_app/screens/signUp_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen(onClickedSignUp: toggle)
      : SignUpScreen(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
