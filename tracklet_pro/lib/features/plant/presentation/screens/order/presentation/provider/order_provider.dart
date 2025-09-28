import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';
import '../../data/dummy_data/order_dummy.dart';

/// Provider for Orders screen state
/// - Holds separate lists for completed and cancelled orders
/// - Exposes tab switching and read-only view of current tab orders
class OrdersProvider extends ChangeNotifier {
  OrdersProvider({bool seedWithDummy = true}) {
    if (seedWithDummy) {
      _completed.addAll(OrderDummy.completedOrders);
      _cancelled.addAll(OrderDummy.cancelledOrders);
    }
  }

  bool _isCompletedTab = true;
  final List<OrderModel> _completed = [];
  final List<OrderModel> _cancelled = [];

  bool get isCompletedTab => _isCompletedTab;

  void switchTab(bool completed) {
    if (_isCompletedTab == completed) return;
    _isCompletedTab = completed;
    notifyListeners();
  }

  List<OrderModel> get orders =>
      _isCompletedTab ? List.unmodifiable(_completed) : List.unmodifiable(_cancelled);

  void addCompleted(OrderModel order) {
    _completed.insert(0, order);
    notifyListeners();
  }

  void addCancelled(OrderModel order) {
    _cancelled.insert(0, order);
    notifyListeners();
  }
}
