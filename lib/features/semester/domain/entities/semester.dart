class SemesterEntity {
  int semesterId;
  double semesterGpa;
  int? totalGpaCredits;
  int? totalNonGpaCredits;

  SemesterEntity(
      {required this.semesterId,
      required this.semesterGpa,
      this.totalGpaCredits,
      this.totalNonGpaCredits});

  factory SemesterEntity.fromJson(Map<String, dynamic> json) {
    return SemesterEntity(
        semesterId: json['semesterId'],
        semesterGpa: json['semesterGpa'],
        totalGpaCredits: json['totalGpaCredits'],
        totalNonGpaCredits: json['totalNonGpaCredits']);
  }

  Map<String, dynamic> toJson() {
    return {
      'semesterId': semesterId,
      'semesterGpa': semesterGpa,
      'totalGpaCredits': totalGpaCredits,
      'totalNonGpaCredits': totalNonGpaCredits
    };
  }
}
