import 'dart:async';

import 'package:tracklet_pro/features/plant/domain/repositories/order_repository.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';

/// Concrete implementation; currently just simulates a network call.
class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<void> saveDecision({
    required OrderModel order,
    required String status,
    double? ratePerKg,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
