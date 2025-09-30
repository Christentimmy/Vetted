import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlideToCreatePost extends StatefulWidget {
  const SlideToCreatePost({super.key});

  @override
  State<SlideToCreatePost> createState() => _SlideToCreatePostState();
}

class _SlideToCreatePostState extends State<SlideToCreatePost> {
  double _alignmentX = -1; // start at left

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _alignmentX += details.primaryDelta! / 100;
      _alignmentX = _alignmentX.clamp(-1.0, 1.0);
    });
  }

  void _onDragEnd(DragEndDetails details) async {
    if (_alignmentX > 0.6) {
      await Future.delayed(const Duration(milliseconds: 130));
      Get.toNamed(AppRoutes.createPostScreen);
    }
    // reset back
    setState(() => _alignmentX = -1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // The arrows background
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 14),
                Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
                Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
              ],
            ),
          ),

          // Draggable edit icon
          GestureDetector(
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              alignment: Alignment(_alignmentX, 0),
              child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
