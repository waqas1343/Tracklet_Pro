class EmployeeModel {
  final String id;
  final String name;
  bool isPresent;

  EmployeeModel({
    required this.id,
    required this.name,
    this.isPresent = false,
  });
}
