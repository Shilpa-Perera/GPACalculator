import 'package:gpa_calculator/config/database_helper.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/semester/domain/repository/semester_repository.dart';
import 'package:sqflite/sqflite.dart';

class SemesterRepositoryImpl implements SemesterRepository {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  @override
  Future<List<SemesterEntity>> getSemesters() async {
    final Database db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query('semesters');
    return List.generate(maps.length, (i) {
      return SemesterEntity(
        semesterId: maps[i]['semesterId'],
        semesterGpa: maps[i]['semesterGpa'],
      );
    });
  }

  @override
  Future<SemesterEntity> getSemester(int id) async {
    final Database db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'semesters',
      where: 'semesterId = ?',
      whereArgs: [id],
    );
    return SemesterEntity(
      semesterId: maps[0]['semesterId'],
      semesterGpa: maps[0]['semesterGpa'],
    );
  }

  @override
  Future<SemesterEntity> createSemester(SemesterEntity semester) async {
    final Database db = await _databaseHandler.database;
    await db.insert('semesters', semester.toJson());
    return semester;
  }

  @override
  Future<SemesterEntity> updateSemester(SemesterEntity semester) async {
    // final Database db = await _databaseHandler.database;
    // await db.update(
    //   'semesters',
    //   semester.toMap(),
    //   where: 'id = ?',
    //   whereArgs: [semester.id],
    // );
    // return semester;
    throw UnimplementedError;
  }

  @override
  Future<SemesterEntity> deleteSemester(int id) async {
    // final Database db = await _databaseHandler.database;
    // await db.delete(
    //   'semesters',
    //   where: 'id = ?',
    //   whereArgs: [id],
    // );
    // return SemesterEntity(id: id);
    throw UnimplementedError;
  }
}
