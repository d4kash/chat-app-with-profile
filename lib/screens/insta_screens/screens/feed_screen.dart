
import 'package:chat_app/GlobalVariables/Constants.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/screens/insta_screens/model/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chat_app/screens/insta_screens/utils/colors.dart';
import 'package:chat_app/screens/insta_screens/widgets/post_card.dart';
import 'package:chat_app/screens/insta_screens/controller/user_provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void signUserOut() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    // await googleSignIn.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  var profileModel;
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(Constant.uid)
          .get();
      print(userSnap.data().toString());
      profileModel = ProfileModel.fromJson(userSnap.data()!);

      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Bytes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1),),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatHomeScreen(profileModel)));

                  // signUserOut();
                },
                icon: Icon(
                  Icons.messenger_outline,
                  color: blackColor,
                ))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('datePublished', descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Uploaded Image"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        PostCard(snap: snapshot.data!.docs[index].data()),
                  );
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }));
  }
}
