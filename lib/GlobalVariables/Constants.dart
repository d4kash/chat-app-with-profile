import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Constant {
  static double height = Get.size.height;
  static double width = Get.size.width;
  static String uid = FirebaseAuth.instance.currentUser!.uid;
     static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
}
