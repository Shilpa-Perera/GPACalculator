import 'package:floor/floor.dart';
import 'package:gpa_calculator/features/semester/domain/entities/semester.dart';

@entity
class Semester extends SemesterEntity {
  @primaryKey
  String semesterId;
  double semesterGpa;

  Semester({required this.semesterId, required this.semesterGpa})
      : super(semesterId: '', semesterGpa: 0.0);

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterId: json['semesterId'],
      semesterGpa: json['semesterGpa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'semesterId': semesterId,
      'semesterGpa': semesterGpa,
    };
  }
}
