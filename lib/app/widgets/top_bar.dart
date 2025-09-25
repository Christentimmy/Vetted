import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Row buildTopBar(BuildContext context) {
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
          Get.toNamed(AppRoutes.notificationScreen);
        },
        child: const Icon(Icons.notifications_none),
      ),
    ],
  );
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
