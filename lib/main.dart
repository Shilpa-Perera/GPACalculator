import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/home/presentation/pages/home_page.dart';
import 'package:gpa_calculator/features/semester/presentation/pages/view_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
import 'package:gpa_calculator/features/settings/domain/usecases/grading_criteria_handler.dart';
import 'package:gpa_calculator/features/settings/presentation/pages/main_settings_page.dart';

void main() => runApp(const GpaCalculator());

class GpaCalculator extends StatelessWidget {
  const GpaCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 3, 6, 95)),
          useMaterial3: true,
          textTheme: GoogleFonts.aDLaMDisplayTextTheme()),
      home: const AppNavigation(),
    );
  }
}

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  final GradingCriteriaHandler handler = GradingCriteriaHandler();
  bool isGradingsAvailable = false;
  int currentPageIndex = 2;
  final List<String> pageTitles = ['My GPA', 'Semesters', 'Settings'];

  @override
  void initState() {
    super.initState();
    _loadGradings();
  }

  void _loadGradings() async {
    List<GradingCriteria> gradings = await handler.handleGetGradings();
    setState(() {
      if (gradings.isNotEmpty) {
        isGradingsAvailable = true;
        currentPageIndex = 0;
      } else {
        currentPageIndex = 2;
      }
    });
  }

  void setPageIndex(int index) {
    setState(() {
      isGradingsAvailable = true;
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text(pageTitles[currentPageIndex])),
          backgroundColor: Color.fromARGB(255, 3, 6, 95),
          titleTextStyle: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 33, 80, 211),
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.auto_graph_rounded),
          //   icon: Icon(Icons.auto_graph_outlined),
          //   label: 'Stats',
          // ),
          NavigationDestination(
            enabled: isGradingsAvailable,
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            enabled: isGradingsAvailable,
            selectedIcon: Icon(Icons.grid_view_rounded),
            icon: Icon(Icons.grid_view_outlined),
            label: 'Semesters',
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
        MainSettingsPage(
            key: Key('main settings_page'),
            onPageChange: (index) {
              setPageIndex(index);
            }),
      ][currentPageIndex],
    );
  }
}
