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
      return SemesterEntity.fromJson(maps[i]);
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
    // print(maps);
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
  Future<int> deleteSemester(int id) async {
    final Database db = await _databaseHandler.database;
    await db.delete(
      'semesters',
      where: 'semesterId = ?',
      whereArgs: [id],
    );
    return id;
  }

  // @override
  // Future<Int> getNextSemesterId() async {
  //   final Database db = await _databaseHandler.database;
  //   // return 1;
  //   throw UnimplementedError;
  // }
}
