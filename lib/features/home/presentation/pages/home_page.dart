import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/circle_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          // Wrapping the Column with Center widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: CustomPaint(
                  foregroundPainter: CircleProgress(70),
                  child: Container(
                    width: 300,
                    height: 300,
                    child: const Center(
                        child: Text('GPA', style: TextStyle(fontSize: 50))),
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total GPA Credits: 150'),
                    Text('Total Non-GPA Credits: 80'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
