import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/insta_screens/model/user.dart' as model;
import 'package:chat_app/screens/insta_screens/controller/user_provider.dart';
import 'package:chat_app/screens/insta_screens/screens/add_post.dart';
import 'package:chat_app/screens/insta_screens/screens/feed_screen.dart';
import 'package:chat_app/screens/insta_screens/screens/profile_screen.dart';
import 'package:chat_app/screens/insta_screens/screens/search_screen.dart';
import 'package:chat_app/screens/insta_screens/utils/colors.dart';
import 'package:get/get.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  final user = FirebaseAuth.instance.currentUser!;
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    addData();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  addData() async {
    UserProvider userProvider = Get.put(UserProvider());
    await userProvider.refereshUser();
  }

  void signUserOut() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    // await googleSignIn.signOut();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationPageSelected(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: signUserOut,
      //       icon: const Icon(Icons.logout),
      //     )
      //   ],
      // ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const FeedScreen(),
          const SearchScreen(),
          const AddPost(),
          ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: _page == 0
                  ? const Icon(
                      CupertinoIcons.house_fill,
                      color: blackColor,
                    )
                  : const Icon(
                      CupertinoIcons.house,
                      color: secondaryColor,
                    ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: _page == 1
                  ? const Icon(
                      CupertinoIcons.search,
                      color: blackColor,
                    )
                  : const Icon(
                      Icons.search,
                      color: secondaryColor,
                    ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: _page == 2
                  ? const Icon(
                      CupertinoIcons.add_circled_solid,
                      color: blackColor,
                    )
                  : const Icon(
                      CupertinoIcons.add_circled,
                      color: secondaryColor,
                    ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 3 ? blackColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor)
        ],
        onTap: navigationPageSelected,
      ),
    );
  }
}
