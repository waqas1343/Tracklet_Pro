import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  bool _rememberMe = false;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  // Getters
  bool get rememberMe => _rememberMe;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  /// Toggle remember me option
  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  /// Perform login operation
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication logic
      if (email.isNotEmpty && password.isNotEmpty) {
        // For demo purposes, accept any email/password combination
        // In real app, this would call actual authentication API
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Please enter both email and password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Logout user
  void logout() {
    _isAuthenticated = false;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Validate email format
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate password strength
  bool isValidPassword(String password) {
    // At least 6 characters for demo
    // In real app, implement proper password strength validation
    return password.length >= 6;
  }

  /// Check if form is valid
  bool isFormValid(String email, String password) {
    return isValidEmail(email) && isValidPassword(password);
  }
}
