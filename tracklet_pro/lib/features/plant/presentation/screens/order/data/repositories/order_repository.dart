import 'dart:async';

import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';

/// Repository stub for persisting order decisions
/// Replace with real API implementation
class OrderRepository {
  Future<void> saveDecision({
    required OrderModel order,
    required String status, // Approved | Cancelled
    double? ratePerKg, // only for approved
  }) async {
    // Simulate network call
    await Future.delayed(const Duration(milliseconds: 300));
    // TODO: integrate real backend API here
  }
}
