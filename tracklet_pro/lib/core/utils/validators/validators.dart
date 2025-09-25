import 'package:flutter/material.dart';

/// Comprehensive validation system for the entire app
class Validators {
  // Regex patterns
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phoneRegExp = RegExp(
    r'^[\+]?[0-9]{10,15}$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z\s]{2,50}$',
  );

  static final RegExp _designationRegExp = RegExp(
    r'^[a-zA-Z\s\-&]{2,100}$',
  );

  // Generic required field validator
  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Email validator with better pattern
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (value.length > 254) {
      return 'Email is too long';
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validator with strong requirements
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (value.length > 128) {
      return 'Password must be less than 128 characters';
    } else if (!_passwordRegExp.hasMatch(value)) {
      return 'Must contain uppercase, lowercase, number and special character';
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

  // Name validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 2) {
      return 'Name must be at least 2 characters';
    } else if (value.length > 50) {
      return 'Name must be less than 50 characters';
    } else if (!_nameRegExp.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  // Designation validator
  static String? validateDesignation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Designation is required';
    } else if (value.length < 2) {
      return 'Designation must be at least 2 characters';
    } else if (value.length > 100) {
      return 'Designation must be less than 100 characters';
    } else if (!_designationRegExp.hasMatch(value)) {
      return 'Designation can only contain letters, spaces, hyphens and ampersands';
    }
    return null;
  }

  // Phone number validator
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!_phoneRegExp.hasMatch(value.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Numeric validators
  static String? validatePositiveNumber(String? value, {String fieldName = 'Number'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    final numValue = num.tryParse(value);
    if (numValue == null) {
      return 'Please enter a valid number';
    } else if (numValue <= 0) {
      return '$fieldName must be greater than 0';
    }
    return null;
  }

  // Min/Max length validators
  static String? validateMinLength(String? value, int minLength, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    } else if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  static String? validateMaxLength(String? value, int maxLength, {String fieldName = 'Field'}) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }
    return null;
  }

  // Custom validation with regex
  static String? validateWithPattern(String? value, RegExp pattern, String errorMessage, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    } else if (!pattern.hasMatch(value)) {
      return errorMessage;
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
  String? validateName() => Validators.validateName(text);
  String? validateDesignation() => Validators.validateDesignation(text);
  String? validatePhone() => Validators.validatePhone(text);
  String? validateRequired({String fieldName = 'Field'}) =>
      Validators.validateRequired(text, fieldName: fieldName);
  String? validateMinLength(int minLength, {String fieldName = 'Field'}) =>
      Validators.validateMinLength(text, minLength, fieldName: fieldName);
  String? validateMaxLength(int maxLength, {String fieldName = 'Field'}) =>
      Validators.validateMaxLength(text, maxLength, fieldName: fieldName);
}

// Form validation helper
class FormValidator {
  static bool validateFormKey(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  static void saveForm(GlobalKey<FormState> formKey) {
    formKey.currentState?.save();
  }

  static void resetForm(GlobalKey<FormState> formKey) {
    formKey.currentState?.reset();
  }
}

// Custom validator widgets for consistent UI
class ValidationBuilder {
  static Widget requiredTextField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator ?? (value) => Validators.validateRequired(value),
    );
  }

  static Widget emailTextField({
    required TextEditingController controller,
    String hintText = 'Enter email address',
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: Validators.validateEmail,
    );
  }

  static Widget passwordTextField({
    required TextEditingController controller,
    String hintText = 'Enter password',
    bool obscureText = true,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      validator: Validators.validatePassword,
    );
  }

  static Widget nameTextField({
    required TextEditingController controller,
    String hintText = 'Enter full name',
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      validator: Validators.validateName,
    );
  }

  static Widget phoneTextField({
    required TextEditingController controller,
    String hintText = 'Enter phone number',
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
      validator: Validators.validatePhone,
    );
  }
}
