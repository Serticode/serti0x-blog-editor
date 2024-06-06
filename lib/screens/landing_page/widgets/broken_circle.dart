import 'dart:math';
import 'package:flutter/material.dart';

class BrokenCirclePainter extends CustomPainter {
  const BrokenCirclePainter({
    required this.paintColour,
  });
  final Color paintColour;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = paintColour
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    const gapAngle = 0.3;
    const segmentAngle = (2 * pi / 3) - gapAngle;

    for (int i = 0; i < 3; i++) {
      final startAngle = (i * 2 * pi / 3) + (gapAngle / 2);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        segmentAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
