import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/modules/community/views/community_screen.dart';
import 'package:Vetted/app/modules/post/views/post_screen.dart';
import 'package:Vetted/app/modules/post/widgets/poll_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedPostScreen extends StatefulWidget {
  const SavedPostScreen({super.key});

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
    final postController = Get.find<PostController>();

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await postController.getSavedPosts();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Posts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(() {
        if (postController.isloading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (postController.savedPosts.isEmpty) {
          return const Center(child: Text("No posts found"));
        }
        return ListView.builder(
          itemCount: postController.savedPosts.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final post = postController.savedPosts[index];
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
}
