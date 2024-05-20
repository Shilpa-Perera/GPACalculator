import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
import 'package:gpa_calculator/features/settings/domain/usecases/grading_criteria_handler.dart';

class SettingsNonEditable extends StatefulWidget {
  const SettingsNonEditable({super.key});

  @override
  State<SettingsNonEditable> createState() => _SettingsNonEditableState();
}

class _SettingsNonEditableState extends State<SettingsNonEditable> {
  final List<GradingCriteria> gradings = [];
  final GradingCriteriaHandler handler = GradingCriteriaHandler();

  @override
  void initState() {
    super.initState();
    _loadGradings();
  }

  void _loadGradings() async {
    List<GradingCriteria> gradings = await handler.handleGetGradings();
    setState(() {
      gradings = gradings;
    });
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
                    controller:
                        TextEditingController(text: "${gradings[0].maxGPA}"),
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Set Maximum GPA',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: gradings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: TextEditingController(
                                text: gradings[index].letterGrade),
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Letter Grade',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: TextEditingController(
                                text: "${gradings[index].numericValue}"),
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Numerical Value',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
