import 'package:gpa_calculator/config/database_helper.dart';
import 'package:gpa_calculator/features/module/domain/entities/module.dart';
import 'package:gpa_calculator/features/module/domain/repository/module_repository.dart';
import 'package:sqflite/sqflite.dart';

class ModuleRepositoryImpl implements ModuleRepository {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  @override
  Future<List<ModuleEntity>> getModulesBySemesterId(int semesterId) async {
    final Database db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'modules',
      where: 'semesterId = ?',
      whereArgs: [semesterId],
    );
    return List.generate(maps.length, (i) {
      return ModuleEntity.fromJson(maps[i]);
    });
  }

  @override
  Future<ModuleEntity> getModuleByName(String moduleName) async {
    final Database db = await _databaseHandler.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'modules',
      where: 'moduleName = ?',
      whereArgs: [moduleName],
    );
    return ModuleEntity.fromJson(maps[0]);
  }

  @override
  Future<ModuleEntity> createModule(ModuleEntity module) async {
    final Database db = await _databaseHandler.database;
    await db.insert('modules', module.toJson());
    return module;
  }

  @override
  Future<String> deleteModuleByName(String moduleName) async {
    final Database db = await _databaseHandler.database;
    await db.delete(
      'modules',
      where: 'moduelName = ?',
      whereArgs: [moduleName],
    );
    return moduleName;
  }

  @override
  Future<ModuleEntity> updateModule(ModuleEntity module) {
    throw UnimplementedError();
  }

  @override
  Future<int> deleteModuleByModuleId(int moduleId) async {
    final Database db = await _databaseHandler.database;
    await db.delete(
      'modules',
      where: 'moduleId = ?',
      whereArgs: [moduleId],
    );
    return moduleId;
  }

  @override
  Future<void> deleteModulesBySemesterId(int semesterId) async {
    final Database db = await _databaseHandler.database;
    await db.delete(
      'modules',
      where: 'semesterId = ?',
      whereArgs: [semesterId],
    );
  }
}
