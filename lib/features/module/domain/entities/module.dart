class ModuleEntity {
  int? id;
  int semesterId;
  String moduleName;
  int isGpa;
  int credit;
  String grade;

  ModuleEntity(
      {required this.semesterId,
      required this.moduleName,
      required this.isGpa,
      required this.credit,
      required this.grade,
      this.id});

  factory ModuleEntity.fromJson(Map<String, dynamic> json) {
    return ModuleEntity(
      id: json['moduleId'],
      semesterId: json['semesterId'],
      moduleName: json['moduleName'],
      isGpa: json['isGpa'],
      credit: json['credit'],
      grade: json['grade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moduleId': id,
      'semesterId': semesterId,
      'moduleName': moduleName,
      'isGpa': isGpa,
      'credit': credit,
      'grade': grade,
    };
  }
}
