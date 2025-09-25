import 'package:flutter/material.dart';

class RateProvider with ChangeNotifier {
  double _todayRate = 250.0;
  final List<Map<String, dynamic>> _history = [
    {"date": "20-Sep-25", "sales": "3200 KG", "rate": 250},
    {"date": "19-Sep-25", "sales": "2800 KG", "rate": 264},
    {"date": "18-Sep-25", "sales": "3000 KG", "rate": 260},
    {"date": "17-Sep-25", "sales": "4000 KG", "rate": 250},
    {"date": "16-Sep-25", "sales": "6000 KG", "rate": 200},
    {"date": "15-Sep-25", "sales": "3000 KG", "rate": 250},
    {"date": "14-Sep-25", "sales": "3000 KG", "rate": 250},
  ];

  String _searchQuery = '';
  String _selectedMonth = '';
  String _selectedRate = '';

  // Getters
  double get todayRate => _todayRate;
  List<Map<String, dynamic>> get history => _history;
  String get searchQuery => _searchQuery;
  String get selectedMonth => _selectedMonth;
  String get selectedRate => _selectedRate;

  List<Map<String, dynamic>> get filteredHistory {
    var filtered = _history;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        return item['date'].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            item['sales'].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            item['rate'].toString().toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
      }).toList();
    }

    if (_selectedMonth.isNotEmpty) {
      filtered = filtered.where((item) {
        return item['date'].toString().contains(_selectedMonth);
      }).toList();
    }

    if (_selectedRate.isNotEmpty) {
      filtered = filtered.where((item) {
        return item['rate'].toString() == _selectedRate;
      }).toList();
    }

    return filtered;
  }

  // Setters
  void setTodayRate(int newRate) {
    _todayRate = newRate.toDouble();
    _history.insert(0, {
      "date": "${DateTime.now().day.toString().padLeft(2, '0')}-Sep-25",
      "sales": "0 KG",
      "rate": newRate,
    });
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedMonth(String month) {
    _selectedMonth = month;
    notifyListeners();
  }

  void setSelectedRate(String rate) {
    _selectedRate = rate;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedMonth = '';
    _selectedRate = '';
    notifyListeners();
  }
}
