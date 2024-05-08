import 'package:gpa_calculator/features/semester/data/models/semester.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';
import 'package:gpa_calculator/features/semester/domain/repository/semester_repository.dart';

class SemesterRepositoryImpl implements SemesterRepository {
  // final
  // final SemesterLocalDataSource semesterLocalDataSource;

  // SemesterRepositoryImpl({
  //   required this.semesterRemoteDataSource,
  //   required this.semesterLocalDataSource,
  // });

  @override
  Future<List<Semester>> getSemesters() async {
    throw UnimplementedError();
  }

  @override
  Future<SemesterEntity> createSemester(SemesterEntity semester) {
    // TODO: implement createSemester
    throw UnimplementedError();
  }

  @override
  Future<SemesterEntity> deleteSemester(int id) {
    // TODO: implement deleteSemester
    throw UnimplementedError();
  }

  @override
  Future<SemesterEntity> getSemester(int id) {
    // TODO: implement getSemester
    throw UnimplementedError();
  }

  @override
  Future<SemesterEntity> updateSemester(SemesterEntity semester) {
    // TODO: implement updateSemester
    throw UnimplementedError();
  }
}
