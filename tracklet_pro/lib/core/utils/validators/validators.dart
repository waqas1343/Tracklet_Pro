import 'package:flutter/material.dart';

class Validators {
  // Simple email pattern (allows most common email formats)
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  // Password pattern: At least 8 chars, 1 letter and 1 number
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\$',
  );

  // Email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!_passwordRegExp.hasMatch(value)) {
      return 'Must contain at least 1 letter and 1 number';
    }
    return null;
  }

  // Confirm password validator
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}

// Extension for TextEditingController
extension ValidatorExtension on TextEditingController {
  String? validateEmail() => Validators.validateEmail(text);
  String? validatePassword() => Validators.validatePassword(text);
  String? validateConfirmPassword(String? password) => 
      Validators.validateConfirmPassword(text, password);
}
