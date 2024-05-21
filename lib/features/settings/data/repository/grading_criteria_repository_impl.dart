import 'package:gpa_calculator/config/database_helper.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';
import 'package:gpa_calculator/features/settings/domain/repository/grading_criteria_repository.dart';
import 'package:sqflite/sqflite.dart';

class GradingCriteriaRepositoryImpl implements GradingCriteriaRepository {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  @override
  Future<void> createGradings(List<GradingCriteria> gradingList) async {
    final Database db = await _databaseHandler.database;
    Batch batch = db.batch();
    for (var grading in gradingList) {
      print(grading);
      batch.insert("gradings", grading.toJson());
    }
    await batch.commit(noResult: true);
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
    throw UnimplementedError();
  }
}
