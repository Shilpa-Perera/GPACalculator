class Module {
  int? moduleid;
  int semesterId;
  String moduleName;
  bool isGpa;
  int credit;
  String grade;

  Module(
      {required this.semesterId,
      required this.moduleName,
      required this.isGpa,
      required this.credit,
      required this.grade});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      semesterId: json['semesterId'],
      moduleName: json['name'],
      isGpa: json['isGpa'],
      credit: json['credit'],
      grade: json['grade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'semesterId': semesterId,
      'name': moduleName,
      'isGpa': isGpa,
      'credit': credit,
      'grade': grade,
    };
  }
}
