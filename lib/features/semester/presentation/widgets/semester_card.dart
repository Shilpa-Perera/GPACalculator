import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/module/presentation/pages/semester_modules.dart';
import 'package:gpa_calculator/features/semester/domain/usecases/semester_handlers.dart';

class SemesterCard extends StatelessWidget {
  final SemesterEntity semester;
  final VoidCallback onDelete;
  final VoidCallback onAdd;

  const SemesterCard(
      {super.key,
      required this.semester,
      required this.onDelete,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SemesterModulesPage({"semesterId": semester.semesterId}),
            ),
          ).then((value) => {onAdd()});
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Semester ${semester.semesterId}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "GPA: ${semester.semesterGpa}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                Text(
                  "GPA Credits: ${semester.totalGpaCredits}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                Text(
                  "Non-GPA Credits: ${semester.totalNonGpaCredits}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red[900],
                  onPressed: () {
                    _deleteSemester(context, semester);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteSemester(BuildContext context, SemesterEntity semester) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Semester ${semester.semesterId}?'),
          content: const Text('Are you sure you want to delete this semester?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await SemesterHandlers().handleDeleteSemester(semester);
                Navigator.of(context).pop();
                onDelete();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
