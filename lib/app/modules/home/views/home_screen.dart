import 'package:Vetted/app/controller/auto_complete_controller.dart';
import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/home/widget/header_drag_widget.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:Vetted/app/widgets/auto_complete_widget.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:Vetted/app/widgets/staggered_column_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final postController = Get.find<PostController>();
  RxBool isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();

  RxString sortBy = 'newest'.obs;
  RxBool showRedFlag = true.obs;
  RxBool showGreenFlag = true.obs;
  Rx<RangeValues> ageRange = const RangeValues(18, 75).obs;

  final locationAddressController = TextEditingController();
  final nameController = TextEditingController();
  final _autoCompleteController = Get.put(AutoCompleteController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (postController.posts.isEmpty) {
        postController.getFeed();
      }
    });
    scrollController.addListener(() async {
      if (isLoadingMore.value) return;
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 1000) {
        isLoadingMore.value = true;
        await postController.getFeed(
          loadMore: true,
          showLoader: false,
          type: "woman",
          personName: nameController.text,
          ageRange: [ageRange.value.start.round(), ageRange.value.end.round()],
          personLocation: locationAddressController.text,
          sort: sortBy.value,
          onlyGreen: showGreenFlag.value,
          onlyRed: showRedFlag.value,
        );
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
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: StaggeredColumnAnimation(
                children: [
                  const SizedBox(height: 12),
                  // buildTopBar(context),
                  buildFirstHeader(context),
                  const SizedBox(height: 20),
                  buildActionRow(context),
                  const SizedBox(height: 20),
                  buildFeed(),
                  SizedBox(height: 12),
                  Obx(() {
                    if (isLoadingMore.value &&
                        postController.posts.isNotEmpty) {
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
      ),
    );
  }

  Row buildFirstHeader(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/logo_black.png', height: 28),
        const SizedBox(width: 8),
        const Text(
          "Vetted",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const Spacer(),

        // Search bar with filter
        SlideToCreatePost(),

        const SizedBox(width: 12),

        // Notifications
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.notificationScreen);
          },
          child: const Icon(Icons.notifications_none),
        ),
      ],
    );
  }

  buildFilterBottomSheet(BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Filter posts",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                // controller: locationAddressController,
                controller: _autoCompleteController.searchFieldController,
                onChanged: (value) {
                  _autoCompleteController.searchText.value = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  contentPadding: const EdgeInsets.all(12),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AutoCompleteList(
                onTap: (v) {
                  String destination = v["name"] ?? "";
                  if (destination.isEmpty) return;
                  // createPostController.selectedCity.value = destination;

                  _autoCompleteController.places.clear();
                  _autoCompleteController.searchFieldController.clear();
                  _autoCompleteController.searchFieldController.text =
                      destination;
                  _autoCompleteController.searchText.value = "";
                },
                autoCompleteController: _autoCompleteController,
              ),
              const SizedBox(height: 12),

              // AGE RANGE
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Age range",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Obx(() {
                return RangeSlider(
                  activeColor: AppColors.primaryColor,
                  values: ageRange.value,
                  min: 18,
                  max: 75,
                  divisions: 57,
                  labels: RangeLabels(
                    "${ageRange.value.start.round()}",
                    "${ageRange.value.end.round()}",
                  ),
                  onChanged: (values) {
                    ageRange.value = values;
                  },
                );
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: Obx(() {
                  return Text(
                    "From ${ageRange.value.start.round()} to ${ageRange.value.end.round()}",
                    style: const TextStyle(color: Colors.black54),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // SORT BY
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sort by",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return Row(
                  children: [
                    Radio<String>(
                      activeColor: AppColors.primaryColor,
                      value: 'newest',
                      groupValue: sortBy.value,
                      onChanged: (value) => sortBy.value = value!,
                    ),
                    const Text('Newest'),
                    Radio<String>(
                      activeColor: AppColors.primaryColor,
                      value: 'oldest',
                      groupValue: sortBy.value,
                      onChanged: (value) => sortBy.value = value!,
                    ),
                    const Text('Oldest'),
                  ],
                );
              }),

              const SizedBox(height: 8),

              // RED & GREEN FLAG TOGGLES (Icon-Based)
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => showRedFlag.value = !showRedFlag.value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Text("Post has"),
                            const SizedBox(height: 6),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.flag,
                                    size: 20,
                                    color:
                                        showRedFlag.value
                                            ? Colors.red
                                            : Colors.grey,
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.flag,
                                    size: 20,
                                    color:
                                        showRedFlag.value
                                            ? Colors.red
                                            : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => showGreenFlag.value = !showGreenFlag.value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Text("Post has"),
                            const SizedBox(height: 6),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.flag,
                                    size: 20,
                                    color:
                                        showGreenFlag.value
                                            ? Colors.green
                                            : Colors.grey,
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.flag,
                                    size: 20,
                                    color:
                                        showGreenFlag.value
                                            ? Colors.green
                                            : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // FILTER BUTTON
              Row(
                children: [
                  CustomButton(
                    width: Get.width * 0.25,
                    ontap: () async {
                      Get.back();
                      nameController.clear();
                      locationAddressController.clear();
                      ageRange.value = const RangeValues(18, 75);
                      sortBy.value = 'newest';
                      showRedFlag.value = true;
                      showGreenFlag.value = true;
                      _autoCompleteController.searchFieldController.clear();
                      await postController.getFeed();
                    },
                    isLoading: false.obs,
                    bgColor: Colors.transparent,
                    border: Border.all(color: AppColors.primaryColor),
                    child: Text(
                      "Reset",
                      style: GoogleFonts.poppins(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Get.back();
                          await postController.getFeed(
                            type: "woman",
                            personName: nameController.text,
                            ageRange: [
                              ageRange.value.start.round(),
                              ageRange.value.end.round(),
                            ],
                            personLocation:
                                _autoCompleteController
                                    .searchFieldController
                                    .text,
                            sort: sortBy.value,
                            onlyGreen: showGreenFlag.value,
                            onlyRed: showRedFlag.value,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
        onTap:
            () => Get.toNamed(
              AppRoutes.postScreen,
              arguments: {'postId': post.id},
            ),
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

            Obx(() {
              return Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () async {
                    await postController.toggleSavePost(postId: post.id!);
                  },
                  child: Icon(
                    post.isBookmarked!.value
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                ),
              );
            }),

            // Positioned(
            //   bottom: 8,
            //   left: 8,
            //   right: 8,
            //   child: Center(
            //     child: BidirectionalVoteSwitch(
            //       leadingFlag: post.stats?.leadingFlag,
            //       hasVoted: post.hasVoted?.value,
            //       votedColor: post.votedColor?.value,
            //       greenCount: post.stats?.greenVotes?.value,
            //       redCount: post.stats?.redVotes?.value,
            //       onVote: (String vote) async {
            //         // Update local state immediately for better UX
            //         updateUiVote(post: post, vote: vote);
            //         await postController.voteOnWoman(
            //           postId: post.id!,
            //           color: vote,
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 15,
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.only(right: 9),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (post.stats?.leadingFlag == 'green')
                            Text(
                              post.stats?.greenVotes?.value.toString() ?? "0",
                              style: GoogleFonts.fredoka(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            )
                          else if (post.stats?.leadingFlag == 'red')
                            Text(
                              post.stats?.redVotes?.value.toString() ?? "0",
                              style: GoogleFonts.fredoka(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            )
                          else
                            Text(
                              "0",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  Obx(() {
                    return Center(
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: _getFlagColor(
                              leadingFlag: post.stats?.leadingFlag?.value,
                            ),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.flag,
                          size: 16,
                          color: _getFlagColor(
                            leadingFlag: post.stats?.leadingFlag?.value,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
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
        Expanded(
          child: Container(
            // width: Get.width * 0.8,
            // height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                    style: TextStyle(fontSize: 14),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        postController.getFeed();
                      }
                    },
                    onSubmitted: (value) {
                      postController.getFeed(
                        showLoader: true,
                        type: "woman",
                        personName: value,
                      );
                    },
                  ),
                ),
          
                IconButton(
                  onPressed: () {
                    buildFilterBottomSheet(context);
                  },
                  icon: Icon(Icons.filter_list, size: 18, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.chatList);
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

  void updateUiVote({required PostModel post, required String vote}) async {
    setState(() {
      if (post.stats?.leadingFlag != vote) {
        // Remove previous vote count
        if (post.stats?.leadingFlag == 'green') {
          post.stats?.greenVotes?.value =
              (post.stats?.greenVotes?.value ?? 1) - 1;
        } else if (post.stats?.leadingFlag == 'red') {
          post.stats?.redVotes?.value = (post.stats?.redVotes?.value ?? 1) - 1;
        }

        // Add new vote count
        if (vote == 'green') {
          post.stats?.greenVotes?.value =
              (post.stats?.greenVotes?.value ?? 0) + 1;
        } else {
          post.stats?.redVotes?.value = (post.stats?.redVotes?.value ?? 0) + 1;
        }

        post.stats?.leadingFlag?.value = vote;
      }
    });
  }
}

_getFlagColor({required String? leadingFlag}) {
  if (leadingFlag == null) {
    return Colors.grey;
  }
  if (leadingFlag == 'green') {
    return Colors.green;
  } else if (leadingFlag == 'red') {
    return Colors.red;
  }
  return Colors.grey;
}
