class EmployeeModel {
  final String id;
  final String name;
  final String designation;
  bool isPresent;
  String status;
  DateTime? lateTime;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.designation,
    this.isPresent = false,
    String? status,
    this.lateTime,
  }) : status = status ?? (isPresent ? 'present' : 'absent');
  void setPresent() {
    isPresent = true;
    status = 'present';
    lateTime = null;
  }

  void setAbsent() {
    isPresent = false;
    status = 'absent';
    lateTime = null;
  }

  void setLate(DateTime time) {
    isPresent = false;
    status = 'late';
    lateTime = time;
  }
}
