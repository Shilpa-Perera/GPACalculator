import 'dart:math';
import 'package:flutter/material.dart';

class ProgressCircle extends StatefulWidget {
  final double percentage;
  final double strokeWidth;
  final Color color;

  const ProgressCircle({
    super.key,
    required this.percentage,
    this.strokeWidth = 10.0,
    this.color = Colors.blue,
  });

  @override
  _ProgressCircleState createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: widget.percentage)
        .animate(_animationController)
      ..addListener(() {
        setState(() {}); // Redraw the widget when animation value changes
      });
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.square(100.0), // Adjust size as needed
      painter: _ProgressCirclePainter(
        percentage: _animation.value,
        strokeWidth: widget.strokeWidth,
        color: widget.color,
      ),
    );
  }
}

class _ProgressCirclePainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color color;

  _ProgressCirclePainter({
    required this.percentage,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth / 2;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    const startAngle = -pi / 2; // Start from top
    final sweepAngle = 2 * pi * percentage / 100;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
