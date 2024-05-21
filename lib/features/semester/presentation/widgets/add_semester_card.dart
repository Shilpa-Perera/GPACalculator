import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/module/presentation/pages/semester_modules.dart';
import 'package:gpa_calculator/features/semester/domain/usecases/semester_handlers.dart';

class AddSemesterCard extends StatefulWidget {
  final VoidCallback onSemesterAdded;

  const AddSemesterCard({Key? key, required this.onSemesterAdded})
      : super(key: key);

  @override
  _AddSemesterCardState createState() => _AddSemesterCardState();
}

class _AddSemesterCardState extends State<AddSemesterCard> {
  final semesterHandlers = SemesterHandlers();
  List<int> semesterList = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () async {
          List<int> newSemesterList =
              await semesterHandlers.handleNextSemesterIdsToAdd();
          setState(() {
            semesterList = newSemesterList;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey[300],
          child: Center(
            child: semesterList.isEmpty
                ? Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.indigo[900],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: semesterList
                          .map((id) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () async {
                                    await semesterHandlers
                                        .handleAddSemester(id);
                                    setState(() {
                                      semesterList = [];
                                      widget.onSemesterAdded();
                                    });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SemesterModulesPage(
                                                {"semesterId": id}),
                                      ),
                                    ).then(
                                        (value) => {widget.onSemesterAdded()});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Semester $id',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
