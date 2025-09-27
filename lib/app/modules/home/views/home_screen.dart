import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/post/widgets/vote_widget.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:Vetted/app/widgets/top_bar.dart';
import 'package:Vetted/screens/message_list_screen.dart';
// import 'package:Vetted/screens/notification_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> likedProfiles = {};
  final postController = Get.find<PostController>();
  RxBool isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // postController.startTimer();
      if (postController.posts.isEmpty) {
        postController.getFeed();
      }
    });
    scrollController.addListener(() async {
      if (isLoadingMore.value) return;
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 1000) {
        isLoadingMore.value = true;
        await postController.getFeed(loadMore: true, showLoader: false);
        isLoadingMore.value = false;
      }
    });
  }

  @override
  void dispose() {
    // postController.stopTimer();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () => postController.getFeed(showLoader: false),
            child: ListView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 12),
                buildTopBar(context),
                const SizedBox(height: 20),
                buildActionRow(context),
                const SizedBox(height: 20),
                buildFeed(),
                SizedBox(height: 12),
                Obx(() {
                  if (isLoadingMore.value && postController.posts.isNotEmpty) {
                    return Loader1();
                  }
                  return const SizedBox.shrink();
                }),
                SizedBox(height: Get.height * 0.12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Obx buildFeed() {
    return Obx(() {
      if (postController.isloading.value) {
        return SizedBox(
          width: Get.width,
          height: Get.height * 0.65,
          child: const Center(child: Loader2()),
        );
      }
      if (postController.posts.isEmpty) {
        return SizedBox(
          width: Get.width,
          height: Get.height * 0.65,
          child: const Center(child: Text("No posts found")),
        );
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: postController.posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final post = postController.posts[index];
          return buildDisplayCard(context, post, index);
        },
      );
    });
  }

  Widget buildDisplayCard(BuildContext context, PostModel post, int index) {
    return VisibilityDetector(
      key: ValueKey(post.id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          postController.addViewedPost(post.id);
        }
      },
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.postScreen),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: post.media?[0].url ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                post.media?[0].url ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    likedProfiles.contains(index)
                        ? likedProfiles.remove(index)
                        : likedProfiles.add(index);
                  });
                },
                child: Icon(
                  likedProfiles.contains(index)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Center(
                child: BidirectionalVoteSwitch(
                  leadingFlag: post.stats?.leadingFlag,
                  hasVoted: post.hasVoted,
                  votedColor: post.votedColor,
                  greenCount: post.stats?.greenVotes,
                  redCount: post.stats?.redVotes,
                  onVote: (String vote) async {
                    // Update local state immediately for better UX
                    updateUiVote(post: post, vote: vote);
                    await postController.voteOnWoman(
                      postId: post.id!,
                      color: vote,
                    );
                  },
                ),
              ),
            ),

            Positioned(
              bottom: 2,
              right: 8,
              child: Text(
                post.personName ?? "",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildActionRow(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! > 0) {
              Get.toNamed(AppRoutes.createPostScreen);
            }
          },
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width * 0.45,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.edit_square,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 14),
                Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
                Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
              ],
            ),
          ),
        ),

        const Spacer(),

        // Send button
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MessageListScreen()),
            );
          },
          child: Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Transform.rotate(
              angle: 12.5,
              child: Icon(
                FontAwesomeIcons.paperPlane,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget singleFlagWithCount({
    required IconData icon,
    required String leadingFlag,
    required int? count,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: getColor(leadingFlag)),
          ),
          child: Icon(icon, size: 14, color: getColor(leadingFlag)),
        ),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void updateUiVote({required PostModel post, required String vote}) async {
    setState(() {
      if (post.stats?.leadingFlag != vote) {
        // Remove previous vote count
        if (post.stats?.leadingFlag == 'green') {
          post.stats?.greenVotes = (post.stats?.greenVotes ?? 1) - 1;
        } else if (post.stats?.leadingFlag == 'red') {
          post.stats?.redVotes = (post.stats?.redVotes ?? 1) - 1;
        }

        // Add new vote count
        if (vote == 'green') {
          post.stats?.greenVotes = (post.stats?.greenVotes ?? 0) + 1;
        } else {
          post.stats?.redVotes = (post.stats?.redVotes ?? 0) + 1;
        }

        post.stats?.leadingFlag = vote;
      }
    });
  }
}

getColor(String leadingFlag) {
  if (leadingFlag == 'green') {
    return Colors.green;
  } else if (leadingFlag == 'red') {
    return Colors.red;
  }
  return Colors.grey;
}
