import 'package:chat_app/screens/insta_screens/resources/auth_method.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/insta_screens/model/user.dart';
import 'package:get/state_manager.dart';


class UserProvider extends GetxController {
  
   late User _user;
  final AuthMedthod _authMedthod = AuthMedthod();

  User get getUser => _user;

  Future<void> refereshUser() async {
    User user = await _authMedthod.getUserDetails();
    _user = user;
    update();
  }
}
