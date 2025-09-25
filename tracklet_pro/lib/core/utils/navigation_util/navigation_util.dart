import 'package:flutter/material.dart';

class NavigationUtils {
  // Push to a new screen
  static Future<T?> push<T extends Object?>(
    BuildContext context,
    Widget screen, {
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  // Push and remove until
  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget screen, {
    bool Function(Route<dynamic>)? predicate,
    RouteSettings? settings,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (context) => screen, settings: settings),
      predicate ?? (Route<dynamic> route) => false,
    );
  }

  // Push with replacement
  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget screen, {
    TO? result,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  }) {
    return Navigator.pushReplacement<T, TO>(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      ),
      result: result,
    );
  }

  // Pop the current screen
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).pop<T>(result);
  }

  // Pop until a specific route
  static void popUntil(
    BuildContext context, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    Navigator.popUntil(
      context,
      predicate ?? (Route<dynamic> route) => route.isFirst,
    );
  }

  // Push a named route with arguments
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  // Push and remove all screens except the new one
  static Future<T?> pushAndRemoveAll<T extends Object?>(
    BuildContext context,
    String newRouteName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      newRouteName,
      (Route<dynamic> route) => false, // Remove all previous routes
      arguments: arguments,
    );
  }

  // Check if can pop
  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

  // Get route arguments
  static T? getRouteArgs<T>(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments as T?;
  }
}
