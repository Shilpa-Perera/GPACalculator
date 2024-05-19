import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/semester/domain/usecases/semester_handlers.dart';
import 'package:gpa_calculator/features/semester/presentation/pages/semester_modules.dart';

class ViewPage extends StatefulWidget {
  ViewPage({super.key});

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final semesterHandlers = SemesterHandlers();
  List<SemesterEntity>? semesters;
  List<int> semesterList = [];

  @override
  void initState() {
    super.initState();
    _loadSemesters();
  }

  Future<void> _loadSemesters() async {
    final loadedSemesters = await semesterHandlers.handleGetSemesters();
    setState(() {
      semesters = loadedSemesters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              _buildAddCard(),
              if (semesters != null)
                ...semesters!.map((item) {
                  return _buildCard(context, item);
                }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, SemesterEntity item) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SemesterModulesPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Semester ${item.semesterId}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "GPA: ${item.semesterGpa}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red[900],
                  onPressed: () {
                    _deleteSemester(context, item);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddCard() {
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
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: semesterList
                            .map((id) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () async {
                                      semesterHandlers.handleAddSemester(id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SemesterModulesPage(),
                                        ),
                                      );
                                      setState(() {
                                        semesterList = [];
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
      ),
    );
  }

  void _deleteSemester(BuildContext context, SemesterEntity semester) {
    // Placeholder for delete action
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Semester  ${semester.semesterId}?'),
          content: Text('Are you sure you want to delete this semester?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await semesterHandlers.handleDeleteSemester(semester);
                Navigator.of(context).pop();
                _loadSemesters();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
