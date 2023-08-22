import 'package:chat_app/GlobalVariables/Constants.dart';
import 'package:chat_app/screens/insta_screens/controller/profile_edit_controller.dart';
import 'package:chat_app/screens/insta_screens/utils/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'package:chat_app/screens/insta_screens/controller/user_provider.dart';
import 'package:chat_app/screens/insta_screens/model/profile_model.dart';
import 'package:chat_app/screens/insta_screens/model/user.dart';
import 'package:chat_app/screens/insta_screens/resources/firestore_method.dart';
import 'package:chat_app/screens/insta_screens/utils/colors.dart';
import 'package:chat_app/screens/insta_screens/utils/snackbar.dart';
import 'package:chat_app/screens/insta_screens/widgets/comment_card.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final snap;
  const EditProfileScreen({super.key, required this.snap});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController bioController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    bioController.dispose();
    nameController.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Get.put(UserProvider()).getUser;
    final EditProfileController profileController =
        Get.put(EditProfileController());
    Uint8List? _image = null;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Future updateProfile(Uint8List? selectedImage, String name, String username,
        String bio) async {
      if (_image != null) {
        profileController.postImage(
          user.username,
          user.uid,
          _image,
        );
      }

      await firebaseFirestore
          .collection('users')
          .doc('${Constant.uid}')
          .update({"fullName": name, "bio": bio, "username": username});
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: mobileBackgroundColor,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50)
            .copyWith(bottom: 30),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _image = file;
                });
              },
              child: Stack(children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(user.photoURL),
                ),
              ]),
            ),
            ProfileTextWidgets(
              controller: nameController,
              label: 'Name',
              lastValue: user.fullName,
            ),
            ProfileTextWidgets(
              controller: bioController,
              label: 'Bio',
              lastValue: user.bio,
            ),
            ProfileTextWidgets(
              controller: usernameController,
              label: 'Username',
              lastValue: user.username,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: SizedBox(
                height: Constant.height / 16,
                width: Constant.width / 1,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                    onPressed: () {
                      updateProfile(
                        _image,
                        nameController.text.isEmpty
                            ? user.fullName
                            : nameController.text,
                        usernameController.text.isEmpty
                            ? user.username
                            : usernameController.text,
                        bioController.text.isEmpty
                            ? user.bio
                            : bioController.text,
                      );
                    },
                    child: Text("Update")),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class ProfileTextWidgets extends StatelessWidget {
  TextEditingController controller;
  String label;
  String lastValue;
  ProfileTextWidgets({
    Key? key,
    required this.controller,
    required this.label,
    required this.lastValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constant.height / 7,
      width: Constant.width / 1,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                label,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: Constant.height / 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  hintText: '$lastValue',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
