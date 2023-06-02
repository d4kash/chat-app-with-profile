import 'package:chat_app/GlobalVariables/Constants.dart';
import 'package:chat_app/screens/insta_screens/model/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat_app/screens/insta_screens/utils/colors.dart';
import 'package:chat_app/screens/insta_screens/utils/snackbar.dart';
import 'package:chat_app/screens/insta_screens/widgets/profile_buttons.dart';

import '../model/user.dart';
import '../controller/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  var profileModel;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      print(userSnap.data().toString());
      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      profileModel = ProfileModel.fromJson(userSnap.data()!);
      userData = userSnap.data()!;
      followers = profileModel.followers!.length;
      following = profileModel.followings!.length;
      isFollowing = profileModel.followers!
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Column buildStatColumn(String title, int count) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                count.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: Text(
                profileModel.username,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.messenger_outline,
                      color: blackColor,
                    ))
              ],
            ),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16).copyWith(top: 0),
                    child: Row(
                      children: [
                        Container(
                          // padding: EdgeInsets.all(10).copyWith(top: 20),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(profileModel.image),
                            radius: 40,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                // width: Constant.width / 2.5,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 25)),
                                    buildStatColumn('Posts', postLen),
                                    buildStatColumn('followers', followers),
                                    buildStatColumn('following', following),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: FirebaseAuth
                                                .instance.currentUser!.uid ==
                                            widget.uid
                                        ? FollowButton(
                                            backgroundColor: Colors.transparent,
                                            borderColor: Colors.black,
                                            text: 'Edit Profile',
                                            textColor: Colors.black)
                                        : isFollowing
                                            ? FollowButton(
                                                backgroundColor:
                                                    Colors.transparent,
                                                borderColor: Colors.black,
                                                text: 'unfollow',
                                                textColor: Colors.black)
                                            : FollowButton(
                                                backgroundColor: Colors.blue,
                                                borderColor: Colors.black,
                                                text: 'follow',
                                                textColor: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //full name
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      profileModel.fullName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  //bio
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
                    alignment: Alignment.bottomLeft,
                    child: Text('bio goes here'),
                  ),

                  new Divider(
                    color: Colors.grey.shade400,
                  ),

                  //posts or reels

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          onPressed: () {},
                          icon: Icon(
                            Icons.video_label_outlined,
                            size: 30,
                            color: Colors.grey.shade600,
                          )),
                      IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          onPressed: () {},
                          icon: Icon(Icons.video_library_outlined,
                              size: 30, color: Colors.grey.shade600)),
                    ],
                  ),

                  //posts grid

                  Expanded(
                    //  child: FutureBuilder(
                    //                future: FirebaseFirestore.instance.collection('posts').get(),
                    //                builder: (context, snapshot) {
                    //                  if (!snapshot.hasData) {
                    //                    const Center(
                    //                      child: CircularProgressIndicator(),
                    //                    );
                    //                  }

                    //                  return MasonryGridView.builder(
                    //                      crossAxisSpacing: 4,
                    //                      mainAxisSpacing: 4,
                    //                      gridDelegate:
                    //   const  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2),
                    //                      itemCount: (snapshot.data! as dynamic).docs.length,
                    //                      itemBuilder: (context, index) {
                    //   return ClipRRect(
                    //     child: Image.network((snapshot.data! as dynamic)
                    //         .docs[index]['postURL']),
                    //   );
                    //                      });
                    //                }
                    //                ),

                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('posts')
                            .where('uid', isEqualTo: widget.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        (snapshot.data! as dynamic).docs.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 3,
                                            mainAxisSpacing: 3),
                                    itemBuilder: (context, index) {
                                      return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          child: Image(
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            image: NetworkImage(
                                                (snapshot.data! as dynamic)
                                                    .docs[index]['postURL']),
                                            fit: BoxFit.cover,
                                          ));
                                    }),
                              );
                            } else {
                              return const Text('Empty data');
                            }
                          } else {
                            return SizedBox(
                                height: Constant.height / 2,
                                width: Constant.width / 2,
                                child: const Text("else"));
                          }
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
