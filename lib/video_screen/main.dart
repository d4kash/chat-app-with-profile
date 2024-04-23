// import 'package:chat_app/video_screen/constants.dart';
// import 'package:chat_app/video_screen/controllers/auth_controller.dart';
// import 'package:chat_app/video_screen/views/screens/auth/login_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp().then((value) {
//     Get.put(AuthController());
//   });
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'TikTok Clone',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: backgroundColor,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
