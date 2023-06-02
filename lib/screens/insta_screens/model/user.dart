import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String fullName;
  final String username;

  final List followers;
  final List followings;
  final String photoURL;

  User({
    required this.email,
    required this.uid,
    required this.fullName,
    required this.username,
 
    required this.followers,
    required this.followings,
    required this.photoURL,
  });


static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoURL: snapshot["image"],
      fullName: snapshot["fullName"],
      followers: snapshot["followers"],
      followings: snapshot["followings"],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'fullName': fullName,
        'username': username,

        'followers': followers,
        'followings': followings,
        'image': photoURL,
      };
}
