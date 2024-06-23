import 'package:flutter/material.dart';

class FootPrintPainter extends CustomPainter {
  final double fillPercentage;

  FootPrintPainter(this.fillPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path();
    // Define the points for the foot shape
    path.moveTo(size.width * 0.3, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.4, size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.6, size.width * 0.8, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width * 0.3, size.height * 0.1);
    path.close();

    // Draw the foot outline
    canvas.drawPath(path, paint..color = Colors.grey[300]!);

    // Calculate the fill path
    final fillPath = Path();
    fillPath.moveTo(size.width * 0.3, size.height * 0.1);
    fillPath.quadraticBezierTo(size.width * 0.1, size.height * 0.4, size.width * 0.5, size.height * 0.8);
    fillPath.quadraticBezierTo(size.width * 0.7, size.height * 0.6, size.width * 0.8, size.height * 0.4);
    fillPath.quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width * 0.3, size.height * 0.1);
    fillPath.close();

    // Clip the fill path based on the fill percentage
    canvas.clipPath(fillPath);
    canvas.drawRect(Rect.fromLTWH(0, size.height * (1 - fillPercentage), size.width, size.height * fillPercentage), paint..color = Colors.green);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CarbonFootprintVisualization extends StatelessWidget {
  final double footprintValue;

  CarbonFootprintVisualization({required this.footprintValue});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 400), // Adjust the size as needed
      painter: FootPrintPainter(footprintValue / 100),
    );
  }
}
