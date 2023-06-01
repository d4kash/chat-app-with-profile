import 'package:flutter/material.dart';
import 'package:chat_app/screens/insta_screens/screens/login_screen.dart';
import 'package:chat_app/screens/insta_screens/screens/signup_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login page
  bool showLoginPage = true;

//toggle between login and register page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(onTap: togglePage);
    } else {
      return SignUpScreen(onTap: togglePage);
    }
  }
}
