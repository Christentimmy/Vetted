import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/post/widgets/post_widgets.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostScreen extends StatefulWidget {
  final String postId;
  const PostScreen({super.key, required this.postId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final postController = Get.find<PostController>();

  RxBool isLoadingMore = false.obs;
  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(() async {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isEmpty || isLoadingMore.value) return;

      // If no more pages, stop early
      if (!postController.hasNextPage.value) return;

      final maxIndex = positions
          .map((e) => e.index)
          .reduce((a, b) => a > b ? a : b);
      final total = postController.posts.length;

      if (maxIndex >= total - 5 && !isLoadingMore.value) {
        isLoadingMore.value = true;
        await postController.getFeed(loadMore: true, showLoader: false);
        isLoadingMore.value = false;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 150));
      final index = postController.posts.indexWhere(
        (post) => post.id == widget.postId,
      );
      if (index != -1) {
        itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
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

      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () => postController.getFeed(showLoader: false),
        child: Obx(() {
          final posts = postController.posts;
          final count = posts.length + (isLoadingMore.value ? 1 : 0);

          return ScrollablePositionedList.builder(
            shrinkWrap: true,
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: count,
            itemBuilder: (context, index) {
              if (index < posts.length) {
                final post = posts[index];
                return PostItem(post: post);
              } else {
                // Loader widget at the bottom
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Loader1()),
                );
              }
            },
          );
        }),
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
    return VisibilityDetector(
      key: ValueKey(post.id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          final postController = Get.find<PostController>();
          postController.addViewedPost(post.id);
        }
      },
      child: Column(
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
              Obx(() {
                print(
                  "refreshijnh.........////...............................",
                );
                return Row(
                  children: [
                    _flagWithCount(
                      Icons.flag,
                      Colors.red,
                      post.stats?.redVotes?.value.toString() ?? "",
                      () async {
                        RxString votedColor = post.votedColor ?? RxString("");
                        RxInt redVotes = post.stats?.redVotes ?? RxInt(0);
                        RxInt greenVotes = post.stats?.greenVotes ?? RxInt(0);

                        if (votedColor.value == "red") {
                          // Already voted red
                          CustomSnackbar.showErrorToast(
                            "You already voted red",
                            position: Position.bottom,
                          );
                          return;
                        }

                        // If voted green before, remove that first
                        if (votedColor.value == "green") {
                          greenVotes.value -= 1;
                        }

                        // Then vote red
                        redVotes.value += 1;
                        votedColor.value = "red";

                        if (post.stats!.greenVotes!.value >=
                            post.stats!.redVotes!.value) {
                          post.stats?.leadingFlag?.value = "green";
                        } else {
                          post.stats?.leadingFlag?.value = "red";
                        }

                        await postController.voteOnWoman(
                          postId: post.id!,
                          color: votedColor.value,
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _flagWithCount(
                      Icons.flag,
                      Colors.green,
                      post.stats?.greenVotes?.value.toString() ?? "",
                      () async {
                        RxString votedColor = post.votedColor ?? RxString("");
                        RxInt redVotes = post.stats?.redVotes ?? RxInt(0);
                        RxInt greenVotes = post.stats?.greenVotes ?? RxInt(0);

                        if (votedColor.value == "green") {
                          // Already voted green
                          CustomSnackbar.showErrorToast(
                            "You already voted green",
                            position: Position.bottom,
                          );
                          return;
                        }

                        // If voted red before, remove that first
                        if (votedColor.value == "red") {
                          redVotes.value -= 1;
                        }

                        // Then vote green
                        greenVotes.value += 1;
                        votedColor.value = "green";

                        if (post.stats!.greenVotes!.value >=
                            post.stats!.redVotes!.value) {
                          post.stats?.leadingFlag?.value = "green";
                        } else {
                          post.stats?.leadingFlag?.value = "red";
                        }

                        await postController.voteOnWoman(
                          postId: post.id!,
                          color: votedColor.value,
                        );
                      },
                    ),
                  ],
                );
              }),
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
      ),
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
