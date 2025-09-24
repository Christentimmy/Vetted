import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/post/widgets/post_widgets.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});

  final postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    // final posts = List.generate(2, (_) => _PostItem());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: postController.posts.length,
        itemBuilder: (context, index) {
          final post = postController.posts[index];
          return PostItem(post: post);
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final PostModel post;
  PostItem({super.key, required this.post});

  final postController = Get.find<PostController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Text(
                "${post.personName}  ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(post.personAge ?? ""),
              const Spacer(),
              Text(post.personLocation ?? ""),
              const SizedBox(width: 8),

              // 3-dot icon with popup
              buildOptionAboutPost(postModel: post, isProfilePost: false),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Image
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(4),
        //   child: Image.asset(
        //     'assets/images/sample_post.png',
        //     fit: BoxFit.cover,
        //     width: double.infinity,
        //     height: 240,
        //   ),
        // ),
        InkWell(
          onTap: () {
            Get.dialog(Image.network(post.media?[0].url ?? ""));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: post.media?[0].url ?? "",
              fit: BoxFit.cover,
              width: double.infinity,
              alignment: Alignment.topCenter,
              height: Get.height * 0.45,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.grey[300]),
                );
              },
              errorWidget:
                  (context, url, error) => const Icon(Icons.broken_image),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _flagWithCount(
                  Icons.flag,
                  Colors.red,
                  post.stats?.redVotes.toString() ?? "",
                  () {},
                ),
                const SizedBox(width: 12),
                _flagWithCount(
                  Icons.flag,
                  Colors.green,
                  post.stats?.greenVotes.toString() ?? "",
                  () {},
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (post.author?.id == userController.userModel.value?.id) {
                  CustomSnackbar.showErrorToast("You can't follow yourself");
                  return;
                }
                post.isFollow.value = !post.isFollow.value;
                await userController.toggleFollow(
                  userId: post.author?.id ?? "",
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Obx(() {
                return Text(
                  post.isFollow.value ? 'Unfollow' : 'Follow',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // View Comments Button (updated)
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ViewAndCommentScreen(),
              //   ),
              // );

              buildCommentSheet(Get.context!, post, false);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Obx(() {
              return Text(
                'View ${post.stats?.comments?.value} Comments',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _circleButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: color),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }

  Widget _flagWithCount(
    IconData icon,
    Color color,
    String count,
    VoidCallback onTap,
  ) {
    return Row(
      children: [
        _circleButton(icon, color, onTap),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            count,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
