import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 102, 9, 131)),
        useMaterial3: true,
      ),
      home: const NavigationBarApp(),
    );
  }
}
