import 'package:flutter/material.dart';
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double spaceWidth;

  DashedBorderPainter({
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.dashWidth = 10.0,
    this.spaceWidth = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double totalWidth = 0.0;

    while (totalWidth < size.width) {
      canvas.drawLine(
        Offset(totalWidth, size.height / 2),
        Offset(totalWidth + dashWidth, size.height / 2),
        paint,
      );
      totalWidth += dashWidth + spaceWidth;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}