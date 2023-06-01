import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/insta_screens/provider/user_provider.dart';
import 'package:chat_app/screens/insta_screens/route%20handling/auth_page.dart';
import 'package:chat_app/screens/insta_screens/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (_)=> UserProvider(),)
        //   ],
        //   child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      // theme: ThemeData.dark()
      //     .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const AuthPage(),
    );
    // );
  }
}
