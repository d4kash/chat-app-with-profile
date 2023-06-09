import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  String? image;
  Timestamp? date;
  String? uid;

  UserModel({
    this.email,
    this.name,
    this.image,
    this.date,
    this.uid,
  });

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      image: snapshot['image'],
      date: snapshot['date'],
      uid: snapshot['uid'],
    );
  }
}
