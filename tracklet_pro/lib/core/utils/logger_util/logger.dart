import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class Logger {
  static const String _tag = 'TrackletPro';
  static bool _isInitialized = false;

  static void initialize() {
    if (!_isInitialized) {
      _isInitialized = true;
      if (kDebugMode) {
        // Enable all logging in debug mode
        developer.log('Logger initialized', name: _tag);
      }
    }
  }

  static void d(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: tag ?? _tag,
        level: 1000, // DEBUG level
      );
    }
  }

  static void i(String message, {String? tag}) {
    if (kDebugMode) {
      developer.log(
        'ℹ️ $message',
        name: tag ?? _tag,
        level: 2000, // INFO level
      );
    }
  }

  static void w(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(
        '⚠️ $message',
        name: tag ?? _tag,
        level: 3000, // WARNING level
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static void e(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    // Always log errors, even in release mode
    developer.log(
      '❌ $message',
      name: tag ?? _tag,
      level: 4000, // ERROR level
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void wtf(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    // What a Terrible Failure - for critical issues
    developer.log(
      '‼️ $message',
      name: tag ?? _tag,
      level: 5000, // WTF level
      error: error,
      stackTrace: stackTrace,
    );
  }
}
