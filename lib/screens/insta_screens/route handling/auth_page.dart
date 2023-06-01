import 'package:chat_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/insta_screens/route%20handling/login_or_registed.dart';
import 'package:chat_app/screens/insta_screens/screens/home_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //is user logged in
          if (snapshot.hasData) {
           return HomeSceen();
          }

          //is user not logged in
          else {
            return  AuthScreen();
          }
        },
      ),
    );
  }
}
