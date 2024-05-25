import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';

class SettingsNonEditable extends StatefulWidget {
  final List<GradingCriteria> gradings;

  final Function onPageChange;

  const SettingsNonEditable(
      {super.key, required this.gradings, required this.onPageChange});

  @override
  State<SettingsNonEditable> createState() => _SettingsNonEditableState();
}

class _SettingsNonEditableState extends State<SettingsNonEditable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            if (widget.gradings.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(
                          text: "${widget.gradings[0].maxGPA}"),
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
            const SizedBox(height: 20),
            if (widget.gradings.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: widget.gradings.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: widget.gradings[index].letterGrade),
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
                                  text:
                                      "${widget.gradings[index].numericValue}"),
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
            if (widget.gradings.isEmpty)
              const Center(
                child: Text(
                  "No grading criteria available.",
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
