

import 'package:flutter/material.dart';

class FaceFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final center = Offset(size.width / 2, size.height / 2 - 50);
    final rect = Rect.fromCenter(
      center: center,
      width: 250,
      height: 300,
    );
    
    // Draw rounded rectangle for face frame
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(20));
    canvas.drawRRect(rrect, paint);
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}