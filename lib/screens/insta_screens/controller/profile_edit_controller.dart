import 'package:chat_app/GlobalVariables/Constants.dart';
import 'package:chat_app/screens/insta_screens/resources/firestore_method.dart';
import 'package:chat_app/screens/insta_screens/resources/storage_methods.dart';
import 'package:chat_app/screens/insta_screens/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class EditProfileController extends GetxController {
  bool isLoading = false;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  void postImage(
    String username,
    String uid,
    Uint8List? _image,
  ) async {
    isLoading = true;

    try {
      String res = await uploadPost(
        uid,
        _image,
        username,
      );
      if (res == 'success') {
        isLoading = false;
      } else {}
    } catch (err) {
      // showSnackBar(err.toString(), context);
    }
  }

  Future<String> uploadPost(
    String uid,
    Uint8List? file,
    String username,
  ) async {
    String res = "some error occured";
    try {
      //storing post image in firebasestorage
      String photoUrl =
          await StorageMethod().uploadImageToStorage('profile', file!, true);

      //storing to firebasefirestore
      firebaseFirestore
          .collection('users')
          .doc('${Constant.uid}')
          .update({"image": photoUrl});
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
