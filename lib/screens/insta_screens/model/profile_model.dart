// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  DateTime? date;
  String? uid;
  String? image;
  List<dynamic>? followers;
  List<String>? followings;
  String? fullName;
  String? email;
  String? username;
  String? bio;

  ProfileModel(
      {this.date,
      this.uid,
      this.image,
      this.followers,
      this.followings,
      this.fullName,
      this.email,
      this.username,
      this.bio});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        date: json["date"].toDate(),
        uid: json["uid"],
        image: json["image"],
        followers: json["followers"] == null
            ? []
            : List<dynamic>.from(json["followers"]!.map((x) => x)),
        followings: json["followings"] == null
            ? []
            : List<String>.from(json["followings"]!.map((x) => x)),
        fullName: json["fullName"],
        email: json["email"],
        username: json["username"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "uid": uid,
        "image": image,
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x)),
        "followings": followings == null
            ? []
            : List<dynamic>.from(followings!.map((x) => x)),
        "fullName": fullName,
        "email": email,
        "username": username,
        "bio": bio
      };
}
