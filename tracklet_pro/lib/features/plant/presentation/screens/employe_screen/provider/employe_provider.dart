import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/model/employe_model.dart';

class EmployeeProvider with ChangeNotifier {
  final List<EmployeeModel> _employees = [
    EmployeeModel(id: "EMP-001", name: "Romail Ahmed", isPresent: true),
    EmployeeModel(id: "EMP-002", name: "Romail Ahmed", isPresent: false),
    EmployeeModel(id: "EMP-003", name: "Romail Ahmed", isPresent: false),
    EmployeeModel(id: "EMP-004", name: "Romail Ahmed", isPresent: true),
    EmployeeModel(id: "EMP-005", name: "Romail Ahmed", isPresent: false),
    EmployeeModel(id: "EMP-006", name: "Romail Ahmed", isPresent: true),
    EmployeeModel(id: "EMP-007", name: "Romail Ahmed", isPresent: false),
    EmployeeModel(id: "EMP-008", name: "Romail Ahmed", isPresent: false),
  ];

  List<EmployeeModel> get employees => _employees;

  int get totalEmployees => _employees.length;

  int get presentCount => _employees.where((e) => e.isPresent).length;

  int get absentCount => _employees.where((e) => !e.isPresent).length;

  void toggleAttendance(String id, bool present) {
    final index = _employees.indexWhere((e) => e.id == id);
    if (index != -1) {
      _employees[index].isPresent = present;
      notifyListeners();
    }
  }
}
