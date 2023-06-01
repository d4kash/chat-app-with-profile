import 'package:flutter/material.dart';
import 'package:chat_app/screens/insta_screens/responsive/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget MobileScreenLayout;
  final Widget WebScreenLayout;

  const ResponsiveLayout({super.key , required this.MobileScreenLayout , required this.WebScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > webScreenSize){
          return WebScreenLayout;
        }
        return MobileScreenLayout;
      },
    );
  }
}
