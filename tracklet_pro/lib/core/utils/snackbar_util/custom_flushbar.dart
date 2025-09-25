import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

/// Utility class for showing Flushbar messages
class CustomFlushbar {
  /// Show a success message
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      duration: duration,
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  /// Show an error message
  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      duration: duration,
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.error, color: Colors.white),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  /// Show an info message
  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      duration: duration,
      backgroundColor: Colors.blue,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.info, color: Colors.white),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}
