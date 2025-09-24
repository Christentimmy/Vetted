import 'package:Vetted/app/controller/post_controller.dart';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/modules/post/widgets/post_widgets.dart';
import 'package:Vetted/app/resources/colors.dart';
import 'package:Vetted/app/utils/timeago.dart';
import 'package:Vetted/app/widgets/loaders.dart';
import 'package:flutter/material.dart';
import 'package:Vetted/screens/notification_screen.dart';
import 'package:get/get.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () => postController.getFeedCommunity(showLoader: false),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            children: [
              // 🔹 Header
              Row(
                children: [
                  Image.asset('assets/images/logo_black.png', height: 28),
                  const SizedBox(width: 8),
                  const Text(
                    "Vetted",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Container(
                    height: 36,
                    width: 160,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 18, color: Colors.grey),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showFilterPopup(context),
                          child: const Icon(
                            Icons.filter_list,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.notifications_none),
                  ),
                ],
              ),

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
            const Icon(Icons.more_vert, size: 20), // Save icon
          ],
        ),
        const SizedBox(height: 4),
        Text(
          timeAgo(post.createdAt),
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
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
        // Row(
        //   children: const [
        //     Icon(Icons.favorite_border, size: 18),
        //     SizedBox(width: 4),
        //     Text('102'),
        //     SizedBox(width: 12),
        //     Text("🙁", style: TextStyle(fontSize: 16)),
        //     SizedBox(width: 4),
        //     Text('21'),
        //     Spacer(),
        //     Text(
        //       "Anonymous",
        //       style: TextStyle(color: Colors.black54, fontSize: 12),
        //     ),
        //     SizedBox(width: 4),
        //     Text("1m", style: TextStyle(color: Colors.black54, fontSize: 12)),
        //   ],
        // ),
      ],
    );
  }
}

void _showFilterPopup(BuildContext context) {
  String sortBy = 'newest';
  bool showRedFlag = true;
  bool showGreenFlag = true;
  double maxDistance = 1500;
  RangeValues ageRange = const RangeValues(18, 75);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 36,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Filter posts",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Anonymous", style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Maximum distance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Slider(
                    value: maxDistance,
                    min: 0,
                    max: 1500,
                    divisions: 30,
                    label: "${maxDistance.round()}+ mi",
                    onChanged: (value) {
                      setState(() => maxDistance = value);
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${maxDistance.round()}+ mi",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Age range",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  RangeSlider(
                    values: ageRange,
                    min: 18,
                    max: 75,
                    divisions: 57,
                    labels: RangeLabels(
                      "${ageRange.start.round()}",
                      "${ageRange.end.round()}",
                    ),
                    onChanged: (values) {
                      setState(() => ageRange = values);
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "From ${ageRange.start.round()} to ${ageRange.end.round()}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sort by",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'newest',
                        groupValue: sortBy,
                        onChanged: (value) => setState(() => sortBy = value!),
                      ),
                      const Text('Newest'),
                      Radio<String>(
                        value: 'oldest',
                        groupValue: sortBy,
                        onChanged: (value) => setState(() => sortBy = value!),
                      ),
                      const Text('Oldest'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap:
                              () => setState(() => showRedFlag = !showRedFlag),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      size: 20,
                                      color:
                                          showRedFlag
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.flag,
                                      size: 20,
                                      color:
                                          showRedFlag
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap:
                              () => setState(
                                () => showGreenFlag = !showGreenFlag,
                              ),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      size: 20,
                                      color:
                                          showGreenFlag
                                              ? Colors.green
                                              : Colors.grey,
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      Icons.flag,
                                      size: 20,
                                      color:
                                          showGreenFlag
                                              ? Colors.green
                                              : Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
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
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
