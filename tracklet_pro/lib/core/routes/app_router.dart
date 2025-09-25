import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/bottom_navbar/plant_bottom_navbar.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/employe_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String employee = '/employee';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const PlantBottomNavbar());
      case AppRoutes.employee:
        return MaterialPageRoute(builder: (_) => const EmployeeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined'),
        ),
      ),
    );
  }
}
