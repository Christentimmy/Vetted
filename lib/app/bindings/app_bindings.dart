

import 'package:Vetted/app/controller/app_service_controller.dart';
import 'package:Vetted/app/controller/auth_controller.dart';
import 'package:Vetted/app/controller/invite_controller.dart';
import 'package:Vetted/app/controller/location_controller.dart';
import 'package:Vetted/app/controller/message_controller.dart';
import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/controller/socket_controller.dart';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/controller/subscription_controller.dart';

import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(StorageController());
    Get.put(AuthController());
    Get.put(LocationController());
    Get.put(PostController());  
    Get.put(AppServiceController());
    Get.put(SocketController());
    Get.put(MessageController());
    Get.put(SubscriptionController());
    Get.put(InviteController());
  }
}