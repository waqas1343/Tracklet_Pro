import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  bool _rememberMe = false;

  bool get rememberMe => _rememberMe;

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }
}
