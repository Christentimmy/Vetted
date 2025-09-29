import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/community/views/community_screen.dart';
import 'package:Vetted/app/modules/post/views/post_screen.dart';
import 'package:Vetted/app/modules/post/widgets/poll_widget.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:Vetted/app/modules/community/views/community_screen.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  final RxList<PostModel> posts = <PostModel>[].obs;
  final userController = Get.find<UserController>();
  final isLoading = false.obs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isLoading.value = true;
      final allPost = await userController.getAllUserPost(
        userId: userController.userModel.value?.id ?? "",
      );
      if (allPost != null) {
        posts.value = allPost;
      }
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Posts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(() {
        if (isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        if (posts.isEmpty) {
          return const Center(child: Text("No posts found"));
        }
        return ListView.builder(
          itemCount: posts.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final post = posts[index];
            if (post.postType == "woman") {
              return PostItem(post: post);
            }
            if (post.postType == "regular" && post.poll == null) {
              return buildPostItem(post: post);
            }
            if (post.poll != null) {
              return buildPollWidget(post: post, isProfilePost: false);
            }

            return const SizedBox.shrink();
          },
        );
      }),
    );
  }

  Widget buildOldCode() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 per row
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder:
          //           (_) => ViewPostAndCommentsScreen(imagePath: posts[index]),
          //     ),
          //   );
          // },
          // child: ClipRRect(
          //   borderRadius: BorderRadius.circular(8),
          //   child: Image.asset(posts[index], fit: BoxFit.cover),
          // ),
        );
      },
    );
  }
}
