import 'package:flutter/material.dart';
import 'notification_screen.dart';
import 'home_screen.dart';
import 'number_check_screen.dart';
import 'criminal_record_search_screen.dart';
import 'reverse_image_screen.dart';
import 'menu_page_screen.dart';
import 'community_screen.dart';
import 'background_check_search_screen.dart';
import 'sex_offenders_map_screen.dart';
import 'court_search_resource_screen.dart';

class BackgroundCheckScreen extends StatelessWidget {
  const BackgroundCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 12),

            // 🔹 Top Header
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

            const Text(
              "Check Phone Number",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "(353) 745-8736",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NumberCheckScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Sex Offenders Map",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SexOffendersMapScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/map_sample.png',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Reverse Image Search",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              "Find his social media profiles",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 12),

            // 🔗 Navigate to ReverseImageScreen
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReverseImageScreen()),
                );
              },
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.greenAccent.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add_photo_alternate_outlined, size: 60),
                      SizedBox(height: 12),
                      Text(
                        "Choose Photo",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ✅ Linked Buttons
            _customButton("Background Check", "Get Started", Colors.green, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BackgroundCheckSearchScreen(),
                ),
              );
            }),
            _customButton(
              "Criminal Record Search",
              "Search Now",
              Colors.green,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CriminalRecordSearchScreen(),
                  ),
                );
              },
            ),
            _customButton(
              "Court Search Resources",
              "View Resources",
              Colors.green,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CourtSearchResourceScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/icons/nav_inactive4.png',
                  height: 24,
                ),
              ),
              Image.asset('assets/images/icons/nav_active1.png', height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const CommunityScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/icons/nav_inactive2.png',
                  height: 24,
                ),
              ), // Active icon
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MenuPageScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/icons/nav_inactive3.png',
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated to accept onTap
  Widget _customButton(
    String title,
    String actionText,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                actionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
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
