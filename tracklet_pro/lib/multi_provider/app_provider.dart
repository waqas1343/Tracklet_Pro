import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/auth/presentation/providers/password_visibility_provider.dart';
import 'package:tracklet_pro/features/auth/presentation/providers/login_provider.dart';
import 'package:tracklet_pro/features/language_selection/providers/language_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/bottom_navbar/provider/bottom_nav_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/providers/plant_summary_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/rates_screen/provider/rate_provider/rate_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/orders_screen/provider/orders_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/stock_screen/provider/stock_provider.dart';
import 'package:tracklet_pro/features/rates/presentation/provider/order_provider.dart';

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

    // Orders Provider
    ChangeNotifierProvider<OrdersProvider>(create: (_) => OrdersProvider()),

    // Stock Provider
    ChangeNotifierProvider<StockProvider>(create: (_) => StockProvider()),
    ChangeNotifierProvider<OrderProvidermain>(
      create: (_) => OrderProvidermain(),
    ),
  ];
}
