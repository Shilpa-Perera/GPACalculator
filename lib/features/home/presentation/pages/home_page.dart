// import 'package:flutter/material.dart';
// import 'package:gpa_calculator/features/home/domain/entities/overall_gpa.dart';
// import 'package:gpa_calculator/features/home/domain/usecases/overall_gpa_handler.dart';
// import 'package:gpa_calculator/features/home/presentation/widgets/circle_progress.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   final overallGpaHandler = OverallGpaHandler();
//   late OverallGpa overallGpa;
//   late AnimationController _controller;
//   Animation<double>? _animation;
//   int totalGpaCredits = 0;
//   int totalNonGpaCredits = 0;
//   double gpa = 0.0;
//   double maxGpa = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     overallGpa = await overallGpaHandler.handleGetGpa();
//     setState(() {
//       gpa = overallGpa.gpa;
//       totalGpaCredits = overallGpa.totalGpaCredits;
//       totalNonGpaCredits = overallGpa.totalNonGpaCredits;
//       maxGpa = overallGpa.maxGpa > 0 ? overallGpa.maxGpa : 4.0;
//     });

//     _animation = Tween<double>(begin: 0, end: (gpa / maxGpa) * 100).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: _animation == null
//                     ? CircularProgressIndicator() // Display a loading indicator while animation is null
//                     : AnimatedBuilder(
//                         animation: _animation!,
//                         builder: (context, child) {
//                           return CustomPaint(
//                             foregroundPainter:
//                                 CircleProgress(_animation!.value),
//                             child: Container(
//                               width: 300,
//                               height: 300,
//                               child: Center(
//                                 child: Text(
//                                   gpa.toStringAsFixed(3),
//                                   style: TextStyle(fontSize: 50),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text('Total GPA Credits: $totalGpaCredits',
//                         style: const TextStyle(fontSize: 20)),
//                     const SizedBox(
//                         height: 10), // Added some space between texts
//                     Text('Total Non-GPA Credits: $totalNonGpaCredits',
//                         style: const TextStyle(fontSize: 20)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/domain/entities/overall_gpa.dart';
import 'package:gpa_calculator/features/home/domain/usecases/overall_gpa_handler.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/circle_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final overallGpaHandler = OverallGpaHandler();
  OverallGpa? overallGpa;
  late AnimationController _controller;
  Animation<double>? _animation;
  int totalGpaCredits = 0;
  int totalNonGpaCredits = 0;
  double gpa = 0.0;
  double maxGpa = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _loadData();
  }

  Future<void> _loadData() async {
    overallGpa = await overallGpaHandler.handleGetGpa();
    setState(() {
      gpa = overallGpa!.gpa;
      totalGpaCredits = overallGpa!.totalGpaCredits;
      totalNonGpaCredits = overallGpa!.totalNonGpaCredits;
      maxGpa = overallGpa!.maxGpa > 0 ? overallGpa!.maxGpa : 4.0;
      _animation = Tween<double>(begin: 0, end: (gpa / maxGpa) * 100).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: overallGpa == null
            ? const SizedBox.shrink()
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: AnimatedBuilder(
                        animation: _animation!,
                        builder: (context, child) {
                          return CustomPaint(
                            foregroundPainter:
                                CircleProgress(_animation!.value),
                            child: Container(
                              width: 300,
                              height: 300,
                              child: Center(
                                child: Text(
                                  gpa.toStringAsFixed(3),
                                  style: TextStyle(fontSize: 50),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Total GPA Credits: $totalGpaCredits',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(
                              height: 10), // Added some space between texts
                          Text('Total Non-GPA Credits: $totalNonGpaCredits',
                              style: const TextStyle(fontSize: 20)),
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
