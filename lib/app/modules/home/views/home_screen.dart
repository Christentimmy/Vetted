import 'package:Vetted/screens/create_post_screen.dart';
import 'package:Vetted/screens/message_list_screen.dart';
import 'package:Vetted/screens/notification_screen.dart';
import 'package:Vetted/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<int> likedProfiles = {};

  final List<Map<String, String>> profiles = [
    {"name": "UK", "img": "assets/images/user1.png"},
    {"name": "Ella", "img": "assets/images/user2.png"},
    {"name": "", "img": "assets/images/user3.png"},
    {"name": "Zo\nElla", "img": "assets/images/user4.png"},
    {"name": "", "img": "assets/images/user5.png"},
    {"name": "", "img": "assets/images/user6.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Top Bar
              Row(
                children: [
                  Image.asset('assets/images/logo_black.png', height: 28),
                  const SizedBox(width: 8),
                  const Text(
                    "Vetted",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),

                  // Search bar with filter
                  Container(
                    width: 160,
                    height: 36,
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

                  // Notifications
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

              const SizedBox(height: 20),

              // Action Row with Swipeable Create Post
              Row(
                children: [
                  GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity != null &&
                          details.primaryVelocity! > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreatePostScreen(),
                          ),
                        );
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
                        children: const [
                          Icon(Icons.edit, color: Colors.white, size: 20),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                            size: 14,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white38,
                            size: 14,
                          ),
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
                        MaterialPageRoute(
                          builder: (_) => const MessageListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/icons/send.png',
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Profile Grid
              Expanded(
                child: GridView.builder(
                  itemCount: profiles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    final isRedFlag = index % 2 == 0;
                    final flagColor = isRedFlag ? Colors.red : Colors.green;
                    final flagCount = isRedFlag ? '40' : '15';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PostScreen()),
                        );
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              profile['img']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
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
                            child: _singleFlagWithCount(
                              icon: Icons.flag,
                              color: flagColor,
                              count: flagCount,
                            ),
                          ),
                          if (profile['name']!.isNotEmpty)
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Text(
                                profile['name']!,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(blurRadius: 2, color: Colors.black),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _singleFlagWithCount({
    required IconData icon,
    required Color color,
    required String count,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: color),
          ),
          child: Icon(icon, size: 14, color: color),
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
            count,
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

                  // MAX DISTANCE
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

                  // AGE RANGE
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

                  // SORT BY
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

                  // RED & GREEN FLAG TOGGLES (Icon-Based)
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

                  // FILTER BUTTON
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
