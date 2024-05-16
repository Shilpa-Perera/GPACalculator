import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/features/module/presentation/pages/add_module_page.dart';

class SemesterModulesPage extends StatelessWidget {
  final List<Map<String, dynamic>> modules = [
    {"name": "Module 1", "grade": "A", "credit": 3, "isGPA": true},
    {"name": "Module 2", "grade": "B+", "credit": 2, "isGPA": false},
    {"name": "Module 3", "grade": "A-", "credit": 4, "isGPA": true},
    {"name": "Module 4", "grade": "B", "credit": 3, "isGPA": false},
    {"name": "Module 1", "grade": "A", "credit": 3, "isGPA": true},
    {"name": "Module 2", "grade": "B+", "credit": 2, "isGPA": false},
    {"name": "Module 3", "grade": "A-", "credit": 4, "isGPA": true},
    {"name": "Module 4", "grade": "B", "credit": 3, "isGPA": false},
  ];

  SemesterModulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Semester Modules'),
          backgroundColor: Color.fromARGB(255, 3, 6, 95),
          titleTextStyle: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )
          // shadowColor: theme.colorScheme.secondary,
          ),
      body: ListView.builder(
        itemCount: modules.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddButton(context);
          } else {
            return _buildModuleCard(context, index - 1);
          }
        },
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, int index) {
    final module = modules[index];
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(module["name"]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Grade: ${module["grade"]}'),
            Text('Credit: ${module["credit"]}'),
            Text(module["isGPA"] ? 'GPA Status' : 'Non-GPA Status'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editModule(context, module);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteModule(context, module);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Add Module'),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddModulePage(),
              ),
            );
          },
        ),
      ),
    );
  }

  void _editModule(BuildContext context, dynamic module) {
    // Placeholder for edit action
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${module["name"]}'),
          content: Text('Implement edit functionality here.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _deleteModule(BuildContext context, dynamic module) {
    // Placeholder for delete action
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${module["name"]}?'),
          content: Text('Are you sure you want to delete this module?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform delete operation
                modules.remove(module);
                // Update UI
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
