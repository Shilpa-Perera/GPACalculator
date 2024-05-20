import 'package:gpa_calculator/features/module/domain/entities/module.dart';

abstract class ModuleRepository {
  Future<List<ModuleEntity>> getModulesBySemesterId(int semesterId);
  Future<ModuleEntity> getModuleByName(String moduleName);
  Future<ModuleEntity> createModule(ModuleEntity module);
  Future<ModuleEntity> updateModule(ModuleEntity module);
  Future<String> deleteModuleByName(String moduelName);
  Future<int> deleteModuleByModuleId(int moduleId);
  Future<void> deleteModulesBySemesterId(int semesterId);
}
