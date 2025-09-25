import 'package:flutter/material.dart';

/// Extension methods for [BuildContext] to make it easier to access common properties
/// and perform common tasks.
extension ContextExtensions on BuildContext {
  // Theme related extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  // MediaQuery related extensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenHeight => mediaQuery.size.height;
  double get screenWidth => mediaQuery.size.width;
  double get statusBarHeight => mediaQuery.padding.top;
  double get bottomPadding => mediaQuery.padding.bottom;
  double get safeAreaHeight => screenHeight - statusBarHeight - bottomPadding;
  
  // Navigation extensions
  void pop<T>([T? result]) => Navigator.of(this).pop<T>(result);
  
  Future<T?> push<T>(Widget page) => Navigator.of(this).push<T>(
        MaterialPageRoute(builder: (_) => page),
      );
      
  Future<T?> pushReplacement<T, TO>(Widget page, {TO? result}) => 
      Navigator.of(this).pushReplacement<T, TO>(
        MaterialPageRoute(builder: (_) => page),
        result: result,
      );
      
  void popUntilFirst() => Navigator.of(this).popUntil((route) => route.isFirst);
  
  // Show dialog extensions
  Future<T?> showAppDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }
  
  // Show modal bottom sheet
  Future<T?> showAppBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      builder: (_) => child,
    );
  }
  
  // Show snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }
  
  // Check if the current platform is mobile
  bool get isMobile => mediaQuery.size.width < 600;
  
  // Check if the current platform is tablet
  bool get isTablet => mediaQuery.size.width >= 600 && mediaQuery.size.width < 1200;
  
  // Check if the current platform is desktop
  bool get isDesktop => mediaQuery.size.width >= 1200;
  
  // Get responsive width based on screen size
  double responsiveWidth(double mobile, double tablet, double desktop) {
    if (isMobile) return mobile;
    if (isTablet) return tablet;
    return desktop;
  }
  
  // Get responsive font size
  double responsiveFontSize(double mobile, double tablet, double desktop) {
    final width = mediaQuery.size.width;
    if (width < 600) return mobile;
    if (width < 1200) return tablet;
    return desktop;
  }
  
  // Check if the device is in dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;
  
  // Get text color based on brightness
  Color get textColor => isDarkMode ? Colors.white : Colors.black;
  
  // Get inverse text color based on brightness
  Color get inverseTextColor => isDarkMode ? Colors.black : Colors.white;
}