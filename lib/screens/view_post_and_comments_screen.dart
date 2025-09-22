import 'package:flutter/material.dart';

class ViewPostAndCommentsScreen extends StatelessWidget {
  final String imagePath;

  const ViewPostAndCommentsScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 User info
            const Text(
              "Diana Allen  21",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Los Angeles, US",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // 📸 Full-width Post Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: screenWidth, // full width
                height: screenWidth * 0.75, // keep aspect ratio (4:3)
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // 🚩 Flags + Anonym
            Row(
              children: [
                _flagButton(Icons.flag, Colors.red, "2"),
                const SizedBox(width: 12),
                _flagButton(Icons.flag, Colors.green, "3"),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Anonym",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📝 Post text
            const Text(
              "“Trust your memory. She’ll try to rewrite it. Fucking gas lighter!”",
              style: TextStyle(fontSize: 16, color: Colors.black, height: 1.4),
            ),

            const SizedBox(height: 28),

            // 💬 Comments section
            const Text(
              "Comments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom flag button (icon + toggle count)
  Widget _flagButton(IconData icon, Color color, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 4),
          Text(
            count,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
