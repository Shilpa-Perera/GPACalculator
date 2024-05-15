import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/home_page.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/predictor_page.dart';
import 'package:gpa_calculator/features/home/presentation/widgets/view_page.dart';
import 'package:google_fonts/google_fonts.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true, textTheme: GoogleFonts.dmSerifDisplayTextTheme()),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 235, 237),
      appBar: AppBar(
        title: const Text('GPA Calculator'),
        backgroundColor: theme.colorScheme.primary,
        shadowColor: theme.colorScheme.secondary,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 33, 80, 211),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.insights),
            icon: Icon(Icons.insights_outlined),
            label: 'Predictor',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.grid_view_rounded),
            icon: Icon(Icons.grid_view_outlined),
            label: 'View',
          ),
        ],
      ),
      body: <Widget>[
        /// Messages page
        const PredictorPage(key: Key('predictor_page')),

        /// Home page
        const HomePage(
          key: Key('home_page'),
        ),

        /// Notifications page
        ViewPage(key: const Key('view_page')),
      ][currentPageIndex],
    );
  }
}
