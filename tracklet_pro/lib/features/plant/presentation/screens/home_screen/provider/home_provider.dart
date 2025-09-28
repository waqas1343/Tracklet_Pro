import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/repositories/order_repository.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/presentation/provider/order_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/provider/sales_summary_provider.dart';

/// Provider dedicated to Home screen for handling new orders workflow
class HomeProvider extends ChangeNotifier {
  HomeProvider({OrderRepository? repository}) : _repository = repository ?? OrderRepository();

  // Start with 12.5 tons => 12,500 KG
  int _availableStockKg = 12500;
  int get availableStockKg => _availableStockKg;

  final OrderRepository _repository;

  // Pending new orders created from Home FAB
  final List<OrderModel> _pendingOrders = [];
  List<OrderModel> get pendingOrders => List.unmodifiable(_pendingOrders);

  void addNewOrder(OrderModel order) {
    _pendingOrders.insert(0, order);
    notifyListeners();
  }

  void _removePendingIfExists(OrderModel order) {
    _pendingOrders.removeWhere((o) => _sameOrder(o, order));
    notifyListeners();
  }

  bool _sameOrder(OrderModel a, OrderModel b) {
    return a.traderName == b.traderName &&
        a.totalKg == b.totalKg &&
        a.requestedItems.join('|') == b.requestedItems.join('|');
  }

  void _deductStock(int kg) {
    _availableStockKg = (_availableStockKg - kg).clamp(0, 1 << 31);
    notifyListeners();
  }

  Future<void> approveOrder({
    required BuildContext context,
    required OrderModel order,
    required double ratePerKg,
  }) async {
    // 1) Update Orders screen (move to Completed)
    final completed = OrderModel(
      traderName: order.traderName,
      requestedItems: order.requestedItems,
      totalKg: order.totalKg,
      totalBill: ratePerKg * order.totalKg,
      status: 'Completed',
      specialInstruction: order.specialInstruction,
      location: order.location,
      driverName: order.driverName,
      createdAt: DateTime.now(),
    );
    context.read<OrdersProvider>().addCompleted(completed);

    // 2) Update Sales Summary
    context.read<SalesSummaryProvider>().addApproved(
          addedKg: order.totalKg,
          addedAmount: (ratePerKg * order.totalKg).toInt(),
        );

    // 3) Deduct stock
    _deductStock(order.totalKg);

    // Remove from pending list if present
    _removePendingIfExists(order);

    // 4) Persist decision in backend
    await _repository.saveDecision(order: order, status: 'Approved', ratePerKg: ratePerKg);

    // 5) Generate report (CSV)
    await _generateAndSaveReport(order: order, ratePerKg: ratePerKg, status: 'Approved', availableStockKg: _availableStockKg);
  }

  Future<void> cancelOrder({
    required BuildContext context,
    required OrderModel order,
  }) async {
    // 1) Update Orders screen (move to Cancelled)
    final cancelled = OrderModel(
      traderName: order.traderName,
      requestedItems: order.requestedItems,
      totalKg: order.totalKg,
      totalBill: order.totalBill,
      status: 'Cancelled',
      specialInstruction: order.specialInstruction,
      location: order.location,
      driverName: order.driverName,
      createdAt: DateTime.now(),
    );
    context.read<OrdersProvider>().addCancelled(cancelled);

    // 2) Optionally reflect in Sales Summary graph (count only)
    context.read<SalesSummaryProvider>().addCancelled();

    // 3) Persist decision in backend
    await _repository.saveDecision(order: order, status: 'Cancelled', ratePerKg: null);

    // 4) Generate report (CSV)
    await _generateAndSaveReport(order: order, ratePerKg: null, status: 'Cancelled', availableStockKg: _availableStockKg);

    // Remove from pending list if present
    _removePendingIfExists(order);
  }

  Future<void> _generateAndSaveReport({
    required OrderModel order,
    required String status,
    required int availableStockKg,
    double? ratePerKg,
  }) async {
    final buffer = StringBuffer();
    buffer.writeln('Order Report');
    buffer.writeln('Status,$status');
    buffer.writeln('Trader,${order.traderName}');
    buffer.writeln('Requested Items,${order.requestedItems.join(" | ")}');
    buffer.writeln('Total KG,${order.totalKg}');
    if (ratePerKg != null) buffer.writeln('Rate/KG,$ratePerKg');
    final totalAmount = ratePerKg != null ? (ratePerKg * order.totalKg) : order.totalBill;
    buffer.writeln('Amount,$totalAmount');
    buffer.writeln('Updated Stock (KG),$availableStockKg');
    buffer.writeln('Generated At,${DateTime.now().toIso8601String()}');

    try {
      final dir = Directory.systemTemp.createTempSync('tracklet_reports');
      final file = File('${dir.path}/order_${DateTime.now().millisecondsSinceEpoch}.csv');
      await file.writeAsString(buffer.toString());
      // You can show a SnackBar path via caller UI if needed
    } catch (_) {
      // Swallow for now; in real app surface to UI
    }
  }
}
