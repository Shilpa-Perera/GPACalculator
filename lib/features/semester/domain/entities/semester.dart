class SemesterEntity {
  int semesterId;
  double semesterGpa;

  SemesterEntity({required this.semesterId, required this.semesterGpa});

  factory SemesterEntity.fromJson(Map<String, dynamic> json) {
    return SemesterEntity(
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
