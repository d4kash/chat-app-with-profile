import 'package:chat_app/screens/insta_screens/controller/user_provider.dart';
import 'package:chat_app/video_screen/controllers/auth_controller.dart';
import 'package:chat_app/video_screen/controllers/comment_controller.dart';
import 'package:chat_app/video_screen/controllers/video_controller.dart';
import 'package:get/get.dart';

class GetBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => UserProvider());
    Get.lazyPut(() => AuthController());
    Get.find<AuthController>();
    Get.lazyPut(() => VideoController());
    Get.find<VideoController>();
    Get.lazyPut(() => CommentController());
  }
}
