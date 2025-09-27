import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/rates/data/model/order_model.dart';
import '../../data/dummy_data/order_dummy.dart';

class OrderProvidermain extends ChangeNotifier {
  bool _isCompletedTab = true;

  bool get isCompletedTab => _isCompletedTab;

  void switchTab(bool completed) {
    _isCompletedTab = completed;
    notifyListeners();
  }

  List<OrderModel> get orders =>
      _isCompletedTab ? OrderDummy.completedOrders : OrderDummy.cancelledOrders;
}
