import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/circle_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void _openSettings() {
    // Add your settings navigation or action here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settings'),
          content: Text('Settings dialog content goes here.'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
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
                      child: Text('GPA', style: TextStyle(fontSize: 50)),
                    ),
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
