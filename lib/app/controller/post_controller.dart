import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/controller/storage_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/models/comment_model.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/data/services/post_service.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  final isloading = false.obs;
  final postService = PostService();

  @override
  void onInit() {
    getFeed(showLoader: false);
    getFeedCommunity(showLoader: false);
    super.onInit();
  }

  //normal-feed
  RxInt currentPage = 1.obs;
  RxBool hasNextPage = false.obs;
  RxList<PostModel> posts = <PostModel>[].obs;

  //community-feed
  RxInt currentPageCommunity = 1.obs;
  RxBool hasNextPageCommunity = false.obs;
  RxList<PostModel> postsCommunity = <PostModel>[].obs;

  final focusNode = FocusNode();
  final commentController = TextEditingController();
  String replyCommentId = "";

  RxList<Comment> comments = <Comment>[].obs;

  final isFetchingComments = false.obs;
  final isReplyingComments = false.obs;

  RxList<PostModel> allPersonalPost = <PostModel>[].obs;

  RxList<String> viewedPostIds = <String>[].obs;
  Timer? timer;

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

  Future<void> getFeedCommunity({
    bool showLoader = true,
    bool? loadMore = false,
  }) async {
    isloading.value = showLoader;
    try {
      if (loadMore == true && hasNextPageCommunity.value) {
        currentPageCommunity++;
      } else {
        currentPageCommunity.value = 1;
      }
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.getFeed(
        token: token,
        currentPage: currentPageCommunity.value,
        type: "regular",
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
        postsCommunity.addAll(
          postsList.map((e) => PostModel.fromJson(e)).toList(),
        );
      } else {
        postsCommunity.clear();
        postsCommunity.addAll(
          postsList.map((e) => PostModel.fromJson(e)).toList(),
        );
        postsCommunity.refresh();
      }
      hasNextPageCommunity.value =
          decoded["data"]?["pagination"]?["hasMore"] ?? false;
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

  Future<void> toggleSavePost({required String postId}) async {
    final postIndex = postsCommunity.indexWhere(
      (element) => element.id == postId,
    );

    if (postIndex == -1) return;
    postsCommunity[postIndex].isBookmarked!.value =
        !postsCommunity[postIndex].isBookmarked!.value;
    postsCommunity.refresh();
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.toggleSavePost(
        token: token,
        postId: postId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      CustomSnackbar.showSuccessToast(message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> reactToPost({
    required String postId,
    required String emoji,
    required String reactedEmoji,
  }) async {
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.reactToPost(
        token: token,
        postId: postId,
        emoji: emoji,
        reactedEmoji: reactedEmoji,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deletePostReaction({required String postId}) async {
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.deletePostReaction(
        token: token,
        postId: postId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> commentOnPost({
    required PostModel postModel,
    required TextEditingController commentController,
  }) async {
    HapticFeedback.lightImpact();
    final userModel = Get.find<UserController>().userModel.value;
    if (userModel == null) return;
    final clientId = Uuid().v4();

    final commentModel = Comment(
      postId: postModel.id,
      content: commentController.text,
      clientId: clientId,
      authorId: Author(
        id: userModel.id,
        displayName: userModel.displayName,
        avatar: userModel.avatar,
      ),
      createdAt: DateTime.now(),
      reactionCount: RxInt(0),
      replyCount: RxInt(0),
      reactedEmoji: RxString(""),
    );

    comments.add(commentModel);
    postModel.stats?.comments?.value++;
    commentController.clear();
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.commentOnPost(
        token: token,
        postId: postModel.id ?? "",
        comment: commentModel.content ?? "",
        clientId: clientId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final data = decoded["data"] ?? "";
      final index = comments.indexWhere(
        (element) => element.clientId == clientId,
      );
      if (index != -1) {
        comments[index].id = data["_id"];
        comments[index].postId = data["postId"];
        comments[index].content = data["content"];
        comments[index].clientId = data["clientId"];
        comments[index].isGhostComment = data["isGhostComment"];
        comments[index].reactionCount = RxInt(data["reactionCount"] ?? 0);
        comments[index].isDeleted = data["isDeleted"];
        comments[index].isPinned = data["isPinned"];
        comments[index].replyCount = RxInt(data["replyCount"] ?? 0);
        comments[index].createdAt = DateTime.parse(data["createdAt"]);
        comments[index].updatedAt = DateTime.parse(data["updatedAt"]);
        comments[index].reactedEmoji = RxString(data["reactedEmoji"] ?? "");
      }
      comments.refresh();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> reactToComment({
    required String postId,
    required String commentId,
    required String emoji,
  }) async {
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.reactToComment(
        token: token,
        postId: postId,
        commentId: commentId,
        emoji: emoji,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> getAllCommentReplies({
    required String parentId,
    required RxInt currentPage,
  }) async {
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return null;
      final response = await postService.getAllCommentReplies(
        token: token,
        parentId: parentId,
        currentPage: currentPage.value,
      );
      if (response == null) return null;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return null;
      }
      final List data = decoded["data"]?["replies"] ?? "";
      final bool hasNextPage =
          decoded["data"]?["pagination"]?["hasMore"] ?? false;

      if (data.isEmpty) return null;
      List<Comment> commentReplies =
          data.map((e) => Comment.fromJson(e)).toList();

      // return commentReplies;
      return {"commentReplies": commentReplies, "hasNextPage": hasNextPage};
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
    return null;
  }

  Future<void> getPostComments({required String postId}) async {
    isFetchingComments.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.getPostComments(
        token: token,
        postId: postId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      comments.clear();
      List<dynamic> commentsList = decoded["data"]?["comments"] ?? [];
      if (commentsList.isEmpty) return;
      comments.addAll(commentsList.map((e) => Comment.fromJson(e)).toList());
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isFetchingComments.value = false;
    }
  }

  Future<void> deleteComment({required String commentId}) async {
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.deleteComment(
        token: token,
        commentId: commentId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      print(decoded);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> replyComment({
    required String commentId,
    required TextEditingController commentController,
  }) async {
    isReplyingComments.value = true;
    final commentIndex = comments.indexWhere(
      (element) => element.id == commentId,
    );
    if (commentIndex == -1) return;
    final comment = comments[commentIndex];
    comment.replyCount!.value++;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final clientId = Uuid().v4();
      final response = await postService.replyComment(
        token: token,
        commentId: commentId,
        comment: commentController.text,
        clientId: clientId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isReplyingComments.value = false;
    }
    commentController.clear();
  }

  Future<void> deletePost({
    required String postId,
    required bool isProfilePost,
  }) async {
    try {
      if (isProfilePost) {
        allPersonalPost.removeWhere((element) => element.id == postId);
        allPersonalPost.refresh();
      }
      posts.removeWhere((element) => element.id == postId);
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await postService.deletePost(
        token: token,
        postId: postId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> viewPosts(List<String> postIds) async {
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      if (postIds.isEmpty) return;
      final response = await postService.viewPosts(
        token: token,
        postId: postIds,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        print("Error-from-view-posts: $message");
        CustomSnackbar.showErrorToast(message);
        return;
      }
      postIds.clear();
      viewedPostIds.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      if (viewedPostIds.isNotEmpty) {
        await viewPosts(viewedPostIds);
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void addViewedPost(String? postId) {
    if (postId == null) return;
    if (viewedPostIds.contains(postId)) return;
    viewedPostIds.add(postId);
  }

}
