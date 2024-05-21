class GradingCriteria {
  double maxGPA;
  String letterGrade;
  double numericValue;

  GradingCriteria(
      {required this.maxGPA,
      required this.letterGrade,
      required this.numericValue});

  factory GradingCriteria.fromJson(Map<String, dynamic> json) {
    return GradingCriteria(
        maxGPA: json['maxGPA'],
        letterGrade: json['letterGrade'],
        numericValue: json['numericalValue']);
  }

  Map<String, dynamic> toJson() {
    return {
      'maxGPA': maxGPA,
      'letterGrade': letterGrade,
      'numericalValue': numericValue
    };
  }
}
