import 'package:chat_app/screens/insta_screens/provider/user_provider.dart';
import 'package:get/get.dart';

class GetBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => UserProvider());
  }
}
