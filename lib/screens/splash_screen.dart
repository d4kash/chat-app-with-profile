import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/insta_screens/route%20handling/auth_page.dart';
import 'package:chat_app/screens/insta_screens/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  Future<Widget> userSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromJson(userData);
      return ChatHomeScreen(userModel);
    } else {
      return AuthScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            // print("sign in Handler data : ${snapshot.data}");
            debugPrint("sent to Loding Page : ${snapshot.data!}");
            // UserModel userModel = UserModel.fromJson(snapshot.data!);
            return HomeSceen();
            // return HomePage(
            //   user: snapshot.data!,
            // );
          } else {
            return AuthPage();
          }
        }
      },
    ));
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: FutureBuilder(
  //       future: userSignedIn(),
  //       builder: (context, AsyncSnapshot<Widget> snapshot) {
  //         if (snapshot.hasData) {
  //           return snapshot.data!;
  //         }
  //         return Scaffold(
  //           body: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
