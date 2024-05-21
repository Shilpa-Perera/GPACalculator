import 'package:gpa_calculator/features/module/data/repository/module_repository_impl.dart';
import 'package:gpa_calculator/features/module/domain/entities/module.dart';
import 'package:gpa_calculator/features/semester/data/repository/semester_repository_impl.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/settings/data/repository/grading_criteria_repository_impl.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';

class ModuleHandlers {
  static final moduleRepositoryImpl = ModuleRepositoryImpl();
  static final semesterRepositoryImpl = SemesterRepositoryImpl();
  static final gradingCriteriaImpl = GradingCriteriaRepositoryImpl();

  Future<List<ModuleEntity>> handleGetModules(int semesterId) async {
    List<ModuleEntity> modules =
        await moduleRepositoryImpl.getModulesBySemesterId(semesterId);
    return modules;
  }

  Future<ModuleEntity> handleAddModule(ModuleEntity module) async {
    ModuleEntity moduleEntity = await moduleRepositoryImpl.createModule(module);
    await handleGPA(module.semesterId);
    return moduleEntity;
  }

  Future<int> handleDeleteModule(int moduleId, int semesterId) async {
    int id = await moduleRepositoryImpl.deleteModuleByModuleId(moduleId);
    await handleGPA(semesterId);
    return id;
  }

  Future<void> handleDeleteModulesBySemId(int semesterId) async {
    await moduleRepositoryImpl.deleteModulesBySemesterId(semesterId);
  }

  Future<void> handleGPA(int semesterId) async {
    try {
      List<ModuleEntity> modules = await handleGetModules(semesterId);
      List<GradingCriteria> gradings =
          await gradingCriteriaImpl.getGradingCriterias();

      Map<String, double> gradeMap = {
        for (var grade in gradings) grade.letterGrade: grade.numericValue,
      };

      var gpaData = modules.fold<Map<String, double>>(
        {'totalGradePoints': 0.0, 'totalCredits': 0, 'totalNonGpaCredits': 0},
        (acc, module) {
          if (module.isGpa == 1) {
            var gradeVal = gradeMap[module.grade] ?? 0.0;
            acc['totalGradePoints'] =
                acc['totalGradePoints']! + module.credit * gradeVal;
            acc['totalCredits'] = acc['totalCredits']! + module.credit;
          } else {
            acc['totalNonGpaCredits'] =
                acc['totalNonGpaCredits']! + module.credit;
          }
          return acc;
        },
      );

      double gpa = (gpaData['totalCredits']! > 0)
          ? gpaData['totalGradePoints']! / gpaData['totalCredits']!
          : 0.0;

      await semesterRepositoryImpl.updateSemester(
        SemesterEntity(
            semesterId: semesterId,
            semesterGpa: double.parse(gpa.toStringAsFixed(3)),
            totalNonGpaCredits: gpaData['totalNonGpaCredits']?.toInt(),
            totalGpaCredits: gpaData['totalCredits']?.toInt()),
      );
    } catch (e) {
      print("Error calculating GPA: $e");
    }
  }
}
