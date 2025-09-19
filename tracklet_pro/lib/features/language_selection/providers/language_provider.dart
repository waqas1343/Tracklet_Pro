import 'package:flutter/foundation.dart';

class LanguageProvider extends ChangeNotifier {
  String _selectedLanguage = 'Eng';

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
