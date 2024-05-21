import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  double currentProgress;
  CircleProgress(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..color = Color.fromARGB(255, 219, 227, 230)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - 50;
    canvas.drawCircle(center, radius, circle);

    Paint animationArc = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color.fromARGB(255, 21, 83, 134),
          Color.fromARGB(255, 232, 74, 187)
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    double angle = 2 * pi * (currentProgress / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      animationArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
