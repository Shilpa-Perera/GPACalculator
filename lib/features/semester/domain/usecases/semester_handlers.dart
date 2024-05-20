import 'dart:async';

import 'package:gpa_calculator/features/module/domain/usecases/module_handlers.dart';
import 'package:gpa_calculator/features/semester/data/repository/semester_repository_impl.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';

class SemesterHandlers {
  static final semesterRepositoryImpl = SemesterRepositoryImpl();
  static final moduleHandler = ModuleHandlers();

  void handleAddSemester(int semesterId) async {
    await semesterRepositoryImpl.createSemester(
        SemesterEntity(semesterId: semesterId, semesterGpa: 4.2));
  }

  Future<List<SemesterEntity>> handleGetSemesters() async {
    List<SemesterEntity> semesters =
        await semesterRepositoryImpl.getSemesters();
    return semesters;
  }

  Future<List<int>> handleNextSemesterIdsToAdd() async {
    // get all semesters available
    List<SemesterEntity> semesters =
        await semesterRepositoryImpl.getSemesters();
    List<int> missedSemesterIds = [];
    if (semesters.isEmpty) {
      missedSemesterIds.add(1);
      return missedSemesterIds;
    }
    List<int> semesterIdList = [];
    semesters.forEach((element) {
      semesterIdList.add(element.semesterId);
    });
    // Sort the list
    semesterIdList.sort();
    // convert this to a set
    Set<int> numberSet = semesterIdList.toSet();
    // loop and find missed;
    int start = 1;
    int end = semesterIdList.last;

    for (var i = start; i <= end; i++) {
      if (!numberSet.contains(i)) {
        missedSemesterIds.add(i);
      }
    }
    missedSemesterIds.add(end + 1);
    return missedSemesterIds;
  }

  Future<int> handleDeleteSemester(SemesterEntity semesterEntity) async {
    await moduleHandler.handleDeleteModulesBySemId(semesterEntity.semesterId);
    return await semesterRepositoryImpl
        .deleteSemester(semesterEntity.semesterId);
  }
}
