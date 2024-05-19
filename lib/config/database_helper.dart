import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'gpa.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE semesters(semesterId INTEGER PRIMARY KEY , semesterGpa REAL)",
        );
        await db.execute(
          "CREATE TABLE modules(moduleId INTEGER PRIMARY KEY , semesterId INTEGER, moduleName TEXT, isGpa INTEGER, credit INTEGER, grade TEXT, FOREIGN KEY(semesterId) REFERENCES semester(semesterId))",
        );
      },
      version: 1,
    );
  }
}
