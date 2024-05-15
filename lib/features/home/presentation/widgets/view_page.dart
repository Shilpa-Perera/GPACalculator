import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'color': Colors.green[100], 'text': "He'd have you all unravel at the"},
    {'color': Colors.green[200], 'text': 'Heed not the rabble'},
    {'color': Colors.green[300], 'text': 'Sound of screams but the'},
    {'color': Colors.green[400], 'text': 'Who scream'},
    {'color': Colors.green[500], 'text': 'Revolution is coming...'},
    {'color': Colors.green[600], 'text': 'Revolution, they...'},
    // Add more data as needed
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
            children: data.map((item) {
              return Card(
                // Wrap Container with Card
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
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
            }).toList(),
          ),
        ),
      ],
    );
  }
}
