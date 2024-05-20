import 'package:gpa_calculator/features/settings/data/repository/grading_criteria_repository_impl.dart';
import 'package:gpa_calculator/features/settings/domain/entities/grading_criteria.dart';

class GradingCriteriaHandler {
  static final gradingCriteriaRepositoryImpl = GradingCriteriaRepositoryImpl();

  Future<List<GradingCriteria>> handleGetGradings() async {
    return await gradingCriteriaRepositoryImpl.getGradingCriterias();
  }
}
