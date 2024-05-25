import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
import 'package:gpa_calculator/features/settings/domain/usecases/grading_criteria_handler.dart';
import 'package:gpa_calculator/features/settings/presentation/widgets/letter_grade.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.onPageChange});
  final Function onPageChange;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _gpaController = TextEditingController();
  final List<LetterGrade> _letterGrades = [];
  bool _settingsAdded = false;
  final GradingCriteriaHandler gradingCriteriaHandler =
      GradingCriteriaHandler();

  void _addInitialGrade() {
    setState(() {
      if (_letterGrades.isEmpty && _gpaController.text.isNotEmpty) {
        _letterGrades.add(LetterGrade());
      }
    });
  }

  void _addNewGrade(int index) {
    if (_letterGrades[index].isValid()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _letterGrades.insert(index + 1, LetterGrade());
        });
      });
    } else {
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
    final List<GradingCriteria> grades = _letterGrades.map((letterGrade) {
      return GradingCriteria(
        letterGrade: letterGrade.letterController.text,
        numericValue: double.tryParse(letterGrade.valueController.text) ?? 0.0,
        maxGPA: maxGPA,
      );
    }).toList();

    _sendToDatabase(maxGPA, grades);
  }

  void _sendToDatabase(double maxGPA, List<GradingCriteria> grades) async {
    await gradingCriteriaHandler.handleCreateGradings(grades);
    setState(() {
      _settingsAdded = true;
    });
    widget.onPageChange(0);
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
                    enabled: !_settingsAdded, // Disable the GPA input field
                  ),
                ),
                if (!_settingsAdded)
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _addInitialGrade,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            if (!_settingsAdded)
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
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you want to add these settings? Once added you can't edit them."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              _sendDataToDatabase();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Add Settings'),
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
