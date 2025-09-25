import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/post/widgets/post_widgets.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/utils/timeago.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:Vetted/app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  RxBool isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  final postController = Get.find<PostController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postController.startTimer();
      if (postController.postsCommunity.isEmpty) {
        postController.getFeedCommunity();
      }
    });

    scrollController.addListener(() async {
      if (isLoadingMore.value) return;
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 1000) {
        isLoadingMore.value = true;
        await postController.getFeedCommunity(
          loadMore: true,
          showLoader: false,
        );
        isLoadingMore.value = false;
      }
    });
  }

  @override
  void dispose() {
    postController.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () => postController.getFeedCommunity(showLoader: false),
          child: ListView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            children: [
              buildTopBar(context),

              const SizedBox(height: 24),

              Obx(() {
                if (postController.isloading.value) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height * 0.65,
                    child: const Center(child: Loader2()),
                  );
                }
                if (postController.postsCommunity.isEmpty) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height * 0.65,
                    child: const Center(child: Text("No posts found")),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: postController.postsCommunity.length,
                  itemBuilder: (context, index) {
                    final post = postController.postsCommunity[index];
                    return _buildPostItem(post: post);
                  },
                );
              }),
              SizedBox(height: 12),
              Obx(() {
                if (isLoadingMore.value &&
                    postController.postsCommunity.isNotEmpty) {
                  return Loader1();
                }
                return const SizedBox.shrink();
              }),
              SizedBox(height: Get.height * 0.12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostItem({required PostModel post}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                post.content?.title ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            // const Icon(Icons.more_vert, size: 20), // Save icon
            buildOptionAboutPost(postModel: post, isProfilePost: false),
          ],
        ),
        Text(
          timeAgo(post.createdAt),
          style: GoogleFonts.fredoka(color: Colors.black54, fontSize: 12),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: Get.width,
            color: const Color(0xFFD9A827),
            padding: const EdgeInsets.all(16),
            child: Text(
              post.content?.text ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        buildPostActionRowWidget(postModel: post),
        const SizedBox(height: 8),
        Divider(color: Colors.grey.shade300, thickness: 1),
        const SizedBox(height: 8),
      ],
    );
  }
}
