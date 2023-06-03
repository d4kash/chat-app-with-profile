import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/insta_screens/controller/bindings.dart';
import 'screens/insta_screens/route handling/auth_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  // overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
      
    return GetMaterialApp(
        initialBinding: GetBindings(),
        title: 'Bytes',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            textTheme: GoogleFonts.robotoTextTheme()),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
