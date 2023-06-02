import 'package:chat_app/GlobalVariables/Constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/insta_screens/model/user.dart' as model;
import 'package:get/state_manager.dart';

class UserProvider extends GetxController {

   model.User? _user;
  // final AuthMedthod _authMedthod = AuthMedthod();
  Future<model.User> getUserDetails() async {
    // User currentUser = Constant.auth.currentUser!;
    DocumentSnapshot snap =
        await Constant.firestore.collection('users').doc(Constant.uid).get();

    return model.User.fromSnap(snap);
  }
  model.User get getUser => _user!;

  Future<void> refereshUser() async {
    model.User user = await getUserDetails();

    _user = user;
    update();
  }
}
