import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';

abstract class GradingCriteriaRepository {
  Future<List<GradingCriteria>> getGradingCriterias();
  Future<GradingCriteria> getGradingValue(String letterGrade);
  Future<GradingCriteria> createGradings(List<GradingCriteria> gradingList);
  // Future<GradingCriteria> updateSemester(GradingCriteria semester);
  // Future<int> deleteSemester(int id);
}
