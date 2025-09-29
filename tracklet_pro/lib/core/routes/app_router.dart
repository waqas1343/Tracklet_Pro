import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/distributor_bottom_nav_bar/distributor_bottom_nav_bar.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employee/employee_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String employee = '/employee';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const DistributorBottomNavBar());
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
