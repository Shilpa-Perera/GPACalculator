import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';

abstract class SemesterRepository {
  Future<List<SemesterEntity>> getSemesters();
  Future<SemesterEntity> getSemester(int id);
  Future<SemesterEntity> createSemester(SemesterEntity semester);
  Future<SemesterEntity> updateSemester(SemesterEntity semester);
  Future<int> deleteSemester(int id);
  // Future<Int> getNextSemesterId();
}
