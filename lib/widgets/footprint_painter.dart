import 'package:flutter/material.dart';

class FootprintPainter extends CustomPainter {
  final double fillPercentage;

  FootprintPainter(this.fillPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    double fillHeight = size.height * fillPercentage;

    // Sol ayak
    Path leftFoot = Path()
      ..moveTo(size.width * 0.25, size.height)
      ..lineTo(size.width * 0.25, size.height - fillHeight)
      ..lineTo(size.width * 0.05, size.height - fillHeight)
      ..lineTo(size.width * 0.05, size.height)
      ..close();

    // Sağ ayak
    Path rightFoot = Path()
      ..moveTo(size.width * 0.75, size.height)
      ..lineTo(size.width * 0.75, size.height - fillHeight)
      ..lineTo(size.width * 0.55, size.height - fillHeight)
      ..lineTo(size.width * 0.55, size.height)
      ..close();

    canvas.drawPath(leftFoot, paint);
    canvas.drawPath(rightFoot, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
