// import 'package:flutter/material.dart';
// import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
// import 'package:gpa_calculator/features/settings/domain/usecases/grading_criteria_handler.dart';
// import 'package:gpa_calculator/features/settings/presentation/pages/settings_page.dart';
// import 'package:gpa_calculator/features/settings/presentation/pages/settings_page_non_editable.dart';

// class MainSettingsPage extends StatefulWidget {
//   const MainSettingsPage({super.key});

//   @override
//   _MainSettingsPageState createState() => _MainSettingsPageState();
// }

// class _MainSettingsPageState extends State<MainSettingsPage> {
//   final GradingCriteriaHandler handler = GradingCriteriaHandler();

//   @override
//   void initState() {
//     super.initState();
//     _loadGradings();
//   }

//   void _loadGradings() async {
//     List<GradingCriteria> gradings = await handler.handleGetGradings();
//     if (gradings.isEmpty) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const SettingsPage(key: Key('settings_page')),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => SettingsNonEditable(gradings: gradings),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
import 'package:gpa_calculator/features/settings/domain/usecases/grading_criteria_handler.dart';
import 'package:gpa_calculator/features/settings/presentation/pages/settings_page.dart';
import 'package:gpa_calculator/features/settings/presentation/pages/settings_page_non_editable.dart';

class MainSettingsPage extends StatefulWidget {
  const MainSettingsPage({super.key});

  @override
  _MainSettingsPageState createState() => _MainSettingsPageState();
}

class _MainSettingsPageState extends State<MainSettingsPage> {
  final GradingCriteriaHandler handler = GradingCriteriaHandler();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GradingCriteria>>(
      future: handler.handleGetGradings(),
      builder: (BuildContext context,
          AsyncSnapshot<List<GradingCriteria>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SettingsPage(key: const Key('settings_page'));
        } else {
          return SettingsNonEditable(gradings: snapshot.data!);
        }
      },
    );
  }
}
