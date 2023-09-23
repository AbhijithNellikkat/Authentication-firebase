import 'package:authentication_firebase_app/auth_page.dart';
import 'package:authentication_firebase_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!!!!'));
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
