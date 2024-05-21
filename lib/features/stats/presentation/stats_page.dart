import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/stats/domain/stats_handler.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final StatsHandler statsHandler = StatsHandler();
  late List<SemesterEntity> semesters;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedSemesters = await statsHandler.handleGetStats();
    setState(() {
      semesters = loadedSemesters;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: LineChart(
                LineChartData(
                  backgroundColor: Colors.white,
                  gridData: FlGridData(show: false),
                  // titlesData: const FlTitlesData(
                  //   bottomTitles:
                  //       AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  //   leftTitles:
                  //       AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  // ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: semesters
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(
                              entry.key.toDouble(), entry.value.semesterGpa))
                          .toList(),
                      isCurved: false,
                      color: Colors.blue[900],
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                ),
              )),
    );
  }
}
