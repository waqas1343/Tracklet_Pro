import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/model/employe_model.dart';

enum AttendanceTab { total, present, absent }

class EmployeeProvider with ChangeNotifier {
  final List<EmployeeModel> _employees = [];

  List<EmployeeModel> get employees => _employees;

  int get totalEmployees => _employees.length;

  int get presentCount => _employees.where((e) => e.isPresent == true).length;

  int get absentCount => _employees.where((e) => e.isPresent == false).length;
  int get lateCount => _employees.where((e) => e.status == 'late').length;

  // Search query state for filtering by ID or Name
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  void setSearchQuery(String q) {
    final nq = q.trim();
    if (_searchQuery == nq) return;
    _searchQuery = nq;
    notifyListeners();
  }

  // Selected tab state (default: present)
  AttendanceTab _selectedTab = AttendanceTab.present;
  AttendanceTab get selectedTab => _selectedTab;

  void setSelectedTab(AttendanceTab tab) {
    if (_selectedTab == tab) return;
    _selectedTab = tab;
    notifyListeners();
  }

  // Filtered employees based on selected tab
  List<EmployeeModel> get filteredEmployees {
    Iterable<EmployeeModel> base;
    switch (_selectedTab) {
      case AttendanceTab.total:
        base = _employees;
        break;
      case AttendanceTab.present:
        base = _employees.where((e) => e.isPresent == true);
        break;
      case AttendanceTab.absent:
        base = _employees.where((e) => e.isPresent == false);
        break;
    }
    if (_searchQuery.isEmpty) return base.toList();
    final q = _searchQuery.toLowerCase();
    return base
        .where((e) => e.id.toLowerCase().contains(q) || e.name.toLowerCase().contains(q))
        .toList();
  }

  void toggleAttendance(String id, bool present) {
    final index = _employees.indexWhere((e) => e.id == id);
    if (index != -1) {
      if (present) {
        _employees[index].setPresent();
      } else {
        _employees[index].setAbsent();
      }
      notifyListeners();
    }
  }

  // UI State: pressed summary card key for visual feedback
  String? _pressedSummaryKey;
  String? get pressedSummaryKey => _pressedSummaryKey;

  void setPressedSummaryKey(String? key) {
    if (_pressedSummaryKey == key) return;
    _pressedSummaryKey = key;
    notifyListeners();
  }

  // Mark an absent employee as late at a specific time
  void markLate(String id, DateTime time) {
    final index = _employees.indexWhere((e) => e.id == id);
    if (index != -1) {
      _employees[index].setLate(time);
      notifyListeners();
    }
  }

  // Add a new employee with auto-generated ID (EMP-XXX)
  void addEmployee(String name, String designation) {
    // Find max numeric part among existing EMP-XXX IDs
    int maxNum = 0;
    for (final e in _employees) {
      final match = RegExp(r'^EMP-(\d+)$').firstMatch(e.id);
      if (match != null) {
        final n = int.tryParse(match.group(1)!) ?? 0;
        if (n > maxNum) maxNum = n;
      }
    }
    final nextNum = maxNum + 1;
    final nextId = 'EMP-${nextNum.toString().padLeft(3, '0')}';

    final newEmp = EmployeeModel(
      id: nextId, 
      name: name, 
      designation: designation,
      // No default attendance - will be null by default
    );
    _employees.add(newEmp);
    notifyListeners();
  }

  // Delete an employee by ID
  void deleteEmployee(String id) {
    _employees.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // Rename an employee
  void renameEmployee(String id, String newName) {
    final idx = _employees.indexWhere((e) => e.id == id);
    if (idx != -1) {
      _employees[idx] = EmployeeModel(
        id: _employees[idx].id,
        name: newName,
        designation: _employees[idx].designation,
        isPresent: _employees[idx].isPresent,
        status: _employees[idx].status,
        lateTime: _employees[idx].lateTime,
      );
      notifyListeners();
    }
  }
}
