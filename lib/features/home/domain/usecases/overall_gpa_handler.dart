import 'dart:async';

import 'package:gpa_calculator/features/home/domain/entities/overall_gpa.dart';
import 'package:gpa_calculator/features/semester/data/repository/semester_repository_impl.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/settings/data/repository/grading_criteria_repository_impl.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';

class OverallGpaHandler {
  static final semesterRepositoryImpl = SemesterRepositoryImpl();
  static final gradingCriteriaImpl = GradingCriteriaRepositoryImpl();

  Future<OverallGpa> handleGetGpa() async {
    List<SemesterEntity> semesters =
        await semesterRepositoryImpl.getSemesters();
    List<GradingCriteria> gradingCriteria =
        await gradingCriteriaImpl.getGradingCriterias();
    double maxGPA = gradingCriteria[0].maxGPA;
    double totalGpa = 0.0;
    int totalCredits = 0;
    int totalNonGpaCredits = 0;
    for (var semester in semesters) {
      totalGpa = totalGpa + semester.semesterGpa * semester.totalGpaCredits!;
      totalCredits = totalCredits + semester.totalGpaCredits!;
      totalNonGpaCredits = totalNonGpaCredits + semester.totalNonGpaCredits!;
    }

    totalGpa = (totalCredits > 0) ? totalGpa / totalCredits : 0.0;
    return OverallGpa(
        gpa: totalGpa,
        maxGpa: maxGPA,
        totalGpaCredits: totalCredits,
        totalNonGpaCredits: totalNonGpaCredits);
  }
}
