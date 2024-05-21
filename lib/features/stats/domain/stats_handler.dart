import 'package:gpa_calculator/features/semester/data/repository/semester_repository_impl.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';

class StatsHandler {
  static final semesterRepositoryImpl = SemesterRepositoryImpl();

  Future<List<SemesterEntity>> handleGetStats() async {
    return await semesterRepositoryImpl.getSemesters();
  }
}
