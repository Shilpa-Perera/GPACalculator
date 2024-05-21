import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/features/module/domain/entities/module.dart';
import 'package:gpa_calculator/features/module/domain/usecases/module_handlers.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
import 'package:gpa_calculator/features/settings/domain/usecases/grading_criteria_handler.dart';

class AddModulePage extends StatefulWidget {
  final Map<dynamic, int> map;

  const AddModulePage(this.map, {Key? key}) : super(key: key);

  @override
  _AddModulePageState createState() => _AddModulePageState();
}

class _AddModulePageState extends State<AddModulePage> {
  late String _moduleName;
  String? _selectedGrade;
  late double _credit;
  late int _isGpa;
  int _semesterId = 0;

  final ModuleHandlers _moduleHandlers = ModuleHandlers();
  final GradingCriteriaHandler gradingCriteriaHandler =
      GradingCriteriaHandler();
  final List<String> grades = [];

  @override
  void initState() {
    super.initState();
    _loadGradings();
    _moduleName = '';
    _credit = 0.0;
    _isGpa = 1;
    _semesterId = widget.map['semesterId']!;
  }

  void _loadGradings() async {
    List<GradingCriteria> gradings =
        await gradingCriteriaHandler.handleGetGradings();
    setState(() {
      for (var grading in gradings) {
        grades.add(grading.letterGrade);
      }
      if (grades.isNotEmpty) {
        _selectedGrade = grades.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Module',
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 6, 95),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Semester ID: $_semesterId'), // Displaying semesterId
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Module Name'),
              onChanged: (value) {
                setState(() {
                  _moduleName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            if (grades.isNotEmpty)
              DropdownButtonFormField<String>(
                value: _selectedGrade,
                items: grades.map((String grade) {
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text(grade),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGrade = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Grade'),
              ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Credit'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _credit = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                const Text('GPA Module'),
                Switch(
                  value: _isGpa == 1,
                  onChanged: (value) {
                    setState(() {
                      _isGpa = value ? 1 : 0;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addModule();
              },
              child: const Text('Add Module'),
            ),
          ],
        ),
      ),
    );
  }

  void _addModule() {
    if (_moduleName.isNotEmpty && _credit > 0 && _selectedGrade != null) {
      final newModule = ModuleEntity(
        semesterId: _semesterId,
        moduleName: _moduleName,
        grade: _selectedGrade!,
        credit: _credit.toInt(),
        isGpa: _isGpa,
      );
      _moduleHandlers.handleAddModule(newModule);
      Navigator.pop(context, true);
    } else {
      // Show error message or handle validation
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
