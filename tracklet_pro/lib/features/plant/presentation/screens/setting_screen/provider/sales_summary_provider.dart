import 'package:flutter/material.dart';

class SalesSummaryProvider extends ChangeNotifier {
  // Summary values
  int totalKgToday = 3200; // example data
  int totalAmountToday = 800000; // PKR

  // Orders overview data (weekly)
  final List<int> weeklyOrders = [45, 30, 50, 40, 53, 28, 42];
  int selectedIndex = 4; // highlight Friday (53)

  // Period filter (Weekly / Monthly / Yearly)
  String period = 'Weekly';
  final List<String> periods = const ['Weekly', 'Monthly', 'Yearly'];

  void setPeriod(String value) {
    if (period == value) return;
    period = value;
    // TODO: fetch/update data according to period
    notifyListeners();
  }
}
