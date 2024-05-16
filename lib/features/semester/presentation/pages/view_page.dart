import 'package:flutter/material.dart';
import 'package:gpa_calculator/features/semester/presentation/pages/semester_modules.dart';

class ViewPage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'color': Colors.green[100], 'text': "Semester 01"},
    {'color': Colors.green[200], 'text': 'Semester 02'},
    {'color': Colors.green[300], 'text': 'Semester 03'},
    {'color': Colors.green[400], 'text': 'Semester 04'},
    {'color': Colors.green[500], 'text': 'Semester 05'},
    {'color': Colors.green[600], 'text': 'Semester 06'},
    {'color': Colors.green[700], 'text': 'Semester 07'},
    {'color': Colors.green[800], 'text': 'Semester 08'},
  ];

  ViewPage({super.key});

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
              ...data.map((item) {
                return _buildCard(context, item);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(context, Map<String, dynamic> item) {
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
          color: item['color'],
          child: Center(
            child: Text(item['text']),
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
        onTap: () {
          debugPrint('Add Card tapped.');
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey[300], // Change color as needed
          child: Center(
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.grey[600], // Change color as needed
            ),
          ),
        ),
      ),
    );
  }
}
