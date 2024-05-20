import 'package:gpa_calculator/features/module/data/repository/module_repository_impl.dart';
import 'package:gpa_calculator/features/module/domain/entities/module.dart';

class ModuleHandlers {
  static final moduleRepositoryImpl = ModuleRepositoryImpl();
  Future<List<ModuleEntity>> handleGetModules(int semesterId) async {
    List<ModuleEntity> modules =
        await moduleRepositoryImpl.getModulesBySemesterId(semesterId);
    return modules;
  }

  Future<ModuleEntity> handleAddModule(ModuleEntity module) async {
    return await moduleRepositoryImpl.createModule(module);
  }

  Future<int> handleDeleteModule(int moduleId) async {
    return await moduleRepositoryImpl.deleteModuleByModuleId(moduleId);
  }

  Future<void> handleDeleteModulesBySemId(int semesterId) async {
    await moduleRepositoryImpl.deleteModulesBySemesterId(semesterId);
  }
}
