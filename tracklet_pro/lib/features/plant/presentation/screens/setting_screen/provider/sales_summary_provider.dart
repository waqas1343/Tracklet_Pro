import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/presentation/provider/order_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';

class SalesSummaryProvider extends ChangeNotifier {
  SalesSummaryProvider(BuildContext context) {
    _ordersProvider = context.read<OrdersProvider>();
    _calculateSalesData();
  }

  late OrdersProvider _ordersProvider;

  // Summary values - calculated from real data
  int totalKgToday = 0;
  int totalAmountToday = 0;

  // Orders overview data (weekly) - calculated from real data
  List<int> weeklyOrders = [0, 0, 0, 0, 0, 0, 0];
  int selectedIndex = 0;

  // Period filter
  String period = 'Weekly';
  final List<String> periods = const ['Weekly', 'Monthly', 'Yearly'];

  void setPeriod(String value) {
    if (period == value) return;
    period = value;
    _calculateSalesData();
    notifyListeners();
  }

  // Called when an order is approved
  void addApproved({required int addedKg, required int addedAmount}) {
    _calculateSalesData();
    notifyListeners();
  }

  // Called when an order is cancelled
  void addCancelled() {
    _calculateSalesData();
    notifyListeners();
  }

  void _calculateSalesData() {
    final completedOrders = _ordersProvider.orders;

    // Calculate today's sales
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    final todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);

    int todayKg = 0;
    int todayAmount = 0;

    for (final order in completedOrders) {
      // Check if order was created today
      if (order.createdAt != null &&
          order.createdAt!.isAfter(todayStart) &&
          order.createdAt!.isBefore(todayEnd)) {
        todayKg += order.totalKg;
        todayAmount += order.totalBill.toInt();
      }
    }

    totalKgToday = todayKg;
    totalAmountToday = todayAmount;

    // Calculate weekly orders (Mon-Sun) - use actual dates
    weeklyOrders = _calculateWeeklyOrders(completedOrders);
    selectedIndex = _todayIndex();
  }

  List<int> _calculateWeeklyOrders(List<OrderModel> orders) {
    final weeklyCounts = [0, 0, 0, 0, 0, 0, 0]; // Mon-Sun

    for (final order in orders) {
      if (order.createdAt != null) {
        final dayIndex = (order.createdAt!.weekday - 1).clamp(0, 6);
        weeklyCounts[dayIndex]++;
      }
    }

    return weeklyCounts;
  }

  int _todayIndex() {
    // DateTime.weekday: Mon=1..Sun=7 -> 0..6
    final w = DateTime.now().weekday;
    return (w - 1).clamp(0, 6);
  }
}
