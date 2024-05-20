import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/settings/presentation/widgets/letter_grade.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _gpaController = TextEditingController();
  final List<LetterGrade> _letterGrades = [];
  bool _settingsAdded = false;

  void _addInitialGrade() {
    setState(() {
      if (_letterGrades.isEmpty && _gpaController.text.isNotEmpty) {
        _letterGrades.add(LetterGrade());
      }
    });
  }

  void _addNewGrade(int index) {
    // Check if current fields are empty
    if (_letterGrades[index].isValid()) {
      // Defer the state change to the end of the frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _letterGrades.insert(index + 1, LetterGrade());
        });
      });
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please fill in the current fields before adding a new one.')),
      );
    }
  }

  void _removeGrade(int index) {
    setState(() {
      _letterGrades.removeAt(index);
    });
  }

  void _sendDataToDatabase() {
    final double maxGPA = double.tryParse(_gpaController.text) ?? 0.0;
    final List<Map<String, dynamic>> grades = _letterGrades.map((letterGrade) {
      return {
        'letter': letterGrade.letterController.text,
        'value': double.tryParse(letterGrade.valueController.text) ?? 0.0,
      };
    }).toList();

    _sendToDatabase(maxGPA, grades);
  }

  void _sendToDatabase(double maxGPA, List<Map<String, dynamic>> grades) {
    // Implement your database sending logic here
    print('Sending to database:');
    print('Max GPA: $maxGPA');
    print('Grades: $grades');
    // Example: You can use Firebase, SQLite, REST API, etc.
    setState(() {
      _settingsAdded = true;
    });
  }

  bool _isSendButtonVisible() {
    return _gpaController.text.isNotEmpty &&
        _letterGrades.isNotEmpty &&
        !_settingsAdded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _gpaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Set Maximum GPA',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addInitialGrade,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _letterGrades.length,
                itemBuilder: (context, index) {
                  return _letterGrades[index].buildRow(
                      context,
                      index,
                      _removeGrade,
                      _addNewGrade,
                      index == _letterGrades.length - 1);
                },
              ),
            ),
            if (_isSendButtonVisible())
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm"),
                        content: Text(
                            "Are you sure you want to add these settings?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              _sendDataToDatabase();
                              Navigator.of(context).pop();
                            },
                            child: Text("Confirm"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Add Settings'),
              ),
            if (_settingsAdded)
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Settings added. You cannot edit them anymore.",
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
