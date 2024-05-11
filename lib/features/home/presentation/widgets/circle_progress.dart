import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint the circle
    Paint circle = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // Taking the center of the canvas
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - 50;
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
