import 'package:tracklet_pro/features/order/data/model/order_model.dart';

class OrderDummy {
  static List<OrderModel> completedOrders = [
    OrderModel(
      traderName: "Arham Traders",
      requestedItems: ["45.4 KG (3)", "15 KG (5)"],
      totalKg: 225,
      totalBill: 56250,
      status: "Completed",
    ),
    OrderModel(
      traderName: "Arham Traders",
      requestedItems: ["45.4 KG (3)", "15 KG (5)"],
      totalKg: 225,
      totalBill: 56250,
      status: "Completed",
    ),
  ];

  static List<OrderModel> cancelledOrders = [];
}
