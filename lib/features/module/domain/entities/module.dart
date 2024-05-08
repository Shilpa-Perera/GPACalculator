class ModuleEntity {
  int? id;
  int semesterId;
  String name;
  bool isGpa;
  int credit;
  String grade;

  ModuleEntity(
      {required this.semesterId,
      required this.name,
      required this.isGpa,
      required this.credit,
      required this.grade});
}
