import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';

/// Abstraction for persisting order decisions
/// Keeping the signature identical to the previous concrete class to avoid behavior changes.
abstract class OrderRepository {
  Future<void> saveDecision({
    required OrderModel order,
    required String status, // Approved | Cancelled
    double? ratePerKg, // only for approved
  });
}
