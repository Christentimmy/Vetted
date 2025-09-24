import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/data/services/post_service.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final isloading = false.obs;
  final postService = PostService();

  @override
  void onInit() {
    getFeed(showLoader: false);
    super.onInit();
  }

  //normal-feed
  RxInt currentPage = 1.obs;
  RxBool hasNextPage = false.obs;
  RxList<PostModel> posts = <PostModel>[].obs;

  Future<void> createPost({
    required PostModel postModel,
    List<File>? files,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;

      final response = await postService.createPost(
        token: token,
        postModel: postModel,
        files: files,
      );

      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      CustomSnackbar.showSuccessToast(message);
      // Get.offAllNamed(AppRoutes.bottomNavigationWidget);
      // await getFeed(showLoader: false);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getFeed({
    bool showLoader = true,
    bool? loadMore = false,
    String? type,
  }) async {
    isloading.value = showLoader;
    try {
      if (loadMore == true && hasNextPage.value) {
        currentPage++;
      } else {
        currentPage.value = 1;
      }
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.getFeed(
        token: token,
        currentPage: currentPage.value,
        type: type ?? "woman",
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List<dynamic> postsList = decoded["data"]?["posts"] ?? [];
      if (loadMore == true) {
        posts.addAll(postsList.map((e) => PostModel.fromJson(e)).toList());
      } else {
        posts.clear();
        posts.addAll(postsList.map((e) => PostModel.fromJson(e)).toList());
      }
      hasNextPage.value = decoded["data"]?["pagination"]?["hasMore"] ?? false;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> voteOnWoman({
    required String postId,
    required String color,
  }) async {
    // int index = posts.indexWhere((element) => element.id == postId);
    // if (index == -1) return;
    // posts[index].hasVoted = true;
    // if (color == "green") {
    //   posts[index].stats!.greenVotes = posts[index].stats!.greenVotes! + 1;
    // } else {
    //   posts[index].stats!.redVotes = posts[index].stats!.redVotes! + 1;
    // }
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.voteOnWoman(
        token: token,
        postId: postId,
        color: color,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      // CustomSnackbar.showSuccessToast(message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}
