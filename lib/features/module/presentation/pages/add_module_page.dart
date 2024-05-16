import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/module/domain/entities/module.dart';

class AddModulePage extends StatefulWidget {
  int semesterId = 4;

  AddModulePage();

  @override
  _AddModulePageState createState() => _AddModulePageState();
}

class _AddModulePageState extends State<AddModulePage> {
  late TextEditingController _nameController;
  late bool _isGpa;
  late int _credit;
  late String _selectedGrade = 'A+'; // Default grade selection

  // List of grades
  final List<String> _grades = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'C-',
    'F'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _isGpa = true;
    _credit = 0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Module'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Module Name'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('GPA Status:'),
                SizedBox(width: 8.0),
                Checkbox(
                  value: _isGpa,
                  onChanged: (value) {
                    setState(() {
                      _isGpa = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _credit = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(labelText: 'Credit'),
            ),
            SizedBox(height: 16.0),
            // Dropdown menu for selecting grade
            DropdownButton<String>(
              value: _selectedGrade,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGrade = newValue!;
                });
              },
              items: _grades.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addModule();
              },
              child: Text('Add Module'),
            ),
          ],
        ),
      ),
    );
  }

  void _addModule() {
    // Validate inputs
    if (_nameController.text.isEmpty || _credit <= 0) {
      // Show error message or toast indicating invalid input
      return;
    }

    ModuleEntity module = ModuleEntity(
      semesterId: widget.semesterId,
      name: _nameController.text,
      isGpa: _isGpa,
      credit: _credit,
      grade: _selectedGrade,
    );

    Navigator.pop(context, module);
  }
}
