import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/auth/presentation/providers/password_visibility_provider.dart';
import 'package:tracklet_pro/features/auth/presentation/providers/login_provider.dart';
import 'package:tracklet_pro/features/language_selection/providers/language_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/bottom_navbar/provider/bottom_nav_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/providers/plant_summary_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/rates_screen/provider/rate_provider/rate_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/presentation/provider/order_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/provider/sales_summary_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/provider/home_provider.dart';
import 'package:tracklet_pro/di/injector.dart';

// A simple default provider class
class AppProvider extends ChangeNotifier {
  // Add any app-wide state here
}

class AppProviders {
  static final List<ChangeNotifierProvider<ChangeNotifier>> providers = [
    // Default provider to ensure the list is never empty
    ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),

    // Password Visibility Provider
    ChangeNotifierProvider<PasswordVisibilityProvider>(
      create: (_) => PasswordVisibilityProvider(),
    ),

    // Login Provider
    ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),

    // Language Provider
    ChangeNotifierProvider<LanguageProvider>(create: (_) => LanguageProvider()),

    // Bottom Nav Provider
    ChangeNotifierProvider<BottomNavProvider>(
      create: (_) => BottomNavProvider(),
    ),

    // Plant Summary Provider
    ChangeNotifierProvider<PlantSummaryProvider>(
      create: (_) => PlantSummaryProvider(),
    ),

    // Employee Provider
    ChangeNotifierProvider<EmployeeProvider>(create: (_) => EmployeeProvider()),

    // Rate Provider
    ChangeNotifierProvider<RateProvider>(create: (_) => RateProvider()),

    // Home Provider (inject OrderRepository)
    ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(repository: Injector.orderRepository),
    ),

    // Orders Provider
    ChangeNotifierProvider<OrdersProvider>(create: (_) => OrdersProvider()),

    // Sales Summary Provider (global to reflect real-time updates)
    ChangeNotifierProvider<SalesSummaryProvider>(
      create: (context) => SalesSummaryProvider(context),
    ),
  ];
}
