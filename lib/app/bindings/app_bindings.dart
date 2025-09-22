

import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(StorageController());
    Get.put(AuthController());
    Get.put(UserController());
  }
}