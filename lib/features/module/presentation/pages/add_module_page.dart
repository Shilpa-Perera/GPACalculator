import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/features/module/domain/entities/module.dart';
import 'package:gpa_calculator/features/module/domain/usecases/module_handlers.dart';

class AddModulePage extends StatefulWidget {
  final Map<dynamic, int> map;

  const AddModulePage(this.map, {Key? key}) : super(key: key);

  @override
  _AddModulePageState createState() => _AddModulePageState();
}

class _AddModulePageState extends State<AddModulePage> {
  late String _moduleName;
  late String _selectedGrade;
  late double _credit;
  late int _isGpa;
  int _semesterId = 0;

  final ModuleHandlers _moduleHandlers = ModuleHandlers();

  @override
  void initState() {
    super.initState();
    _moduleName = '';
    _selectedGrade = 'A+';
    _credit = 0.0;
    _isGpa = 1;
    _semesterId = widget.map['semesterId']!;
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
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Semester ID: $_semesterId'), // Displaying semesterId
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Module Name'),
              onChanged: (value) {
                setState(() {
                  _moduleName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedGrade,
              items: ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'F']
                  .map((String grade) {
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
              decoration: InputDecoration(labelText: 'Grade'),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Credit'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _credit = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('GPA Module'),
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
    if (_moduleName.isNotEmpty && _credit > 0) {
      final newModule = ModuleEntity(
        semesterId: _semesterId,
        moduleName: _moduleName,
        grade: _selectedGrade,
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
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
