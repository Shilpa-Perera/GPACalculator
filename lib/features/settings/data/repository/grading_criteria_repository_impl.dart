import 'package:gpa_calculator/config/database_helper.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
import 'package:gpa_calculator/features/settings/domain/repository/grading_criteria_repository.dart';
import 'package:sqflite/sqflite.dart';

class GradingCriteriaRepositoryImpl implements GradingCriteriaRepository {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  @override
  Future<GradingCriteria> createGradings(List<GradingCriteria> gradingList) {
    // TODO: implement createGradings
    throw UnimplementedError();
  }

  @override
  Future<List<GradingCriteria>> getGradingCriterias() async {
    final Database db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query('gradings');
    return List.generate(maps.length, (i) {
      return GradingCriteria.fromJson(maps[i]);
    });
  }

  @override
  Future<GradingCriteria> getGradingValue(String letterGrade) {
    // TODO: implement getGradingValue
    throw UnimplementedError();
  }
}
