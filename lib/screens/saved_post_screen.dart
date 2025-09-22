import 'package:flutter/material.dart';
import 'view_post_and_comments_screen.dart';

class SavedPostScreen extends StatelessWidget {
  const SavedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final savedPosts = [
      'assets/images/user1.png',
      'assets/images/user2.png',
      'assets/images/user3.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Posts"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 per row
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: savedPosts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => ViewPostAndCommentsScreen(
                        imagePath: savedPosts[index],
                      ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(savedPosts[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
