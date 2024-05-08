import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "Gpa.db";
  static const _databaseVersion = 1;
  static DatabaseHelper? _instance;

  DatabaseHelper._();

  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  static Future<Database> get database async {
    _instance?._database ??= await _initDatabase();
    return _instance!._database!;
  }

  Database? _database;

  static Future<Database> _initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE semester(semesterId INTEGER PRIMARY KEY , semesterGpa REAL)",
      );
      await db.execute(
        "CREATE TABLE module(moduleId INTEGER PRIMARY KEY , semesterId INTEGER, moduleName TEXT, isGpa INTEGER, credit INTEGER, grade TEXT, FOREIGN KEY(semesterId) REFERENCES semester(semesterId))",
      );
    });
  }
}
