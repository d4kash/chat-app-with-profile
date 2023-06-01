// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    DateTime? date;
    String? image;
    String? uid;
    List<dynamic>? followers;
    List<dynamic>? followings;
    String? name;
    String? email;

    ProfileModel({
        this.date,
        this.image,
        this.uid,
        this.followers,
        this.followings,
        this.name,
        this.email,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        date: json["date"].toDate(),
        image: json["image"],
        uid: json["uid"],
        followers: json["followers"] == null ? [] : List<dynamic>.from(json["followers"]!.map((x) => x)),
        followings: json["followings"] == null ? [] : List<dynamic>.from(json["followings"]!.map((x) => x)),
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "image": image,
        "uid": uid,
        "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
        "followings": followings == null ? [] : List<dynamic>.from(followings!.map((x) => x)),
        "name": name,
        "email": email,
    };
}
