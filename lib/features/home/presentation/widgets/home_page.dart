import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/circle_progress.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: CustomPaint(
              foregroundPainter: CircleProgress(),
              child: Container(
                width: 300,
                height: 300,
                color: Colors.blue,
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
    ));
  }
}
