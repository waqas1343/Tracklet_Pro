import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  /// Returns true if the string is a valid email
  bool get isEmail => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(this);

  /// Returns true if the string is a valid phone number
  bool get isPhoneNumber => RegExp(r'^[0-9+\-()\s]{10,20}$').hasMatch(this);

  /// Capitalizes the first letter of the string
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Converts the string to title case
  String get toTitleCase => toLowerCase().split(' ').map((word) {
        if (word.isEmpty) return '';
        return '${word[0].toUpperCase()}${word.substring(1)}';
      }).join(' ');

  /// Returns true if the string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Returns true if the string is not null and not empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns the string with the first letter of each word capitalized
  String get toTitleCaseWords =>
      split(' ').map((str) => str.capitalize).join(' ');

  /// Parses the string to a DateTime object
  DateTime? toDateTime({String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return null;
    }
  }

  /// Returns the string with the first [n] characters
  String take(int n, {String suffix = '...'}) {
    if (length <= n) return this;
    return '${substring(0, n)}$suffix';
  }

  /// Returns a color from a hex color string
  Color toColor({Color fallback = Colors.black}) {
    try {
      return Color(
        int.parse(replaceFirst('#', '0xFF')),
      );
    } catch (e) {
      return fallback;
    }
  }

  /// Returns the string with all special characters removed
  String get removeSpecialChars =>
      replaceAll(RegExp(r'[^\s\w]'), '').replaceAll(' ', '');

  /// Returns the string with only numbers
  String get numbersOnly => replaceAll(RegExp(r'[^0-9]'), '');

  /// Returns the string as a double or null if not a valid number
  double? toDoubleOrNull() => double.tryParse(this);

  /// Returns the string as an int or null if not a valid number
  int? toIntOrNull() => int.tryParse(this);
}