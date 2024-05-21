import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/semester/domain/usecases/semester_handlers.dart';
import 'package:gpa_calculator/features/semester/presentation/widgets/add_semester_card.dart';
import 'package:gpa_calculator/features/semester/presentation/widgets/semester_card.dart';

class ViewPage extends StatefulWidget {
  ViewPage({super.key});

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final semesterHandlers = SemesterHandlers();
  List<SemesterEntity>? semesters;

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
              AddSemesterCard(onSemesterAdded: _loadSemesters),
              if (semesters != null)
                ...semesters!.map((item) {
                  return SemesterCard(
                    semester: item,
                    onDelete: () {
                      _loadSemesters();
                    },
                    onAdd: () {
                      _loadSemesters();
                    },
                  );
                }),
            ],
          ),
        ),
      ],
    );
  }
}
