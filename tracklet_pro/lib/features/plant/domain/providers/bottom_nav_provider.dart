import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}

class BottomNavItem {
  final String iconPath;
  final String label;
  final String activeIconPath;

  const BottomNavItem({
    required this.iconPath,
    required this.label,
    this.activeIconPath = '',
  });
}
