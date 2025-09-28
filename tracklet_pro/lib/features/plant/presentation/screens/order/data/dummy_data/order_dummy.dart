import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';

class OrderDummy {
  static List<OrderModel> completedOrders = [
    OrderModel(
      traderName: "Arham Traders",
      requestedItems: ["45.4 KG (3)", "15 KG (5)"],
      totalKg: 225,
      totalBill: 56250,
      status: "Completed",
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    OrderModel(
      traderName: "Arham Traders",
      requestedItems: ["45.4 KG (3)", "15 KG (5)"],
      totalKg: 225,
      totalBill: 56250,
      status: "Completed",
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  static List<OrderModel> cancelledOrders = [];
}
