import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/presentation/pages/home_page.dart';
import 'package:gpa_calculator/features/semester/presentation/pages/view_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/features/settings/presentation/pages/main_settings_page.dart';

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
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 237, 235, 237),
      appBar: AppBar(
          title: const Center(child: Text('GPA Calculator')),
          backgroundColor: Color.fromARGB(255, 3, 6, 95),
          titleTextStyle: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )
          // shadowColor: theme.colorScheme.secondary,
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
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.auto_graph_rounded),
          //   icon: Icon(Icons.auto_graph_outlined),
          //   label: 'Stats',
          // ),
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
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        // Stats page
        // const StatsPage(key: Key('stats_page')),

        /// Home page
        const HomePage(
          key: Key('home_page'),
        ),

        /// Notifications page
        ViewPage(key: const Key('view_page')),

        // Settings page
        const MainSettingsPage(key: Key('main settings_page')),
      ][currentPageIndex],
    );
  }
}
