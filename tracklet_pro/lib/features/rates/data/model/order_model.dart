class OrderModel {
  final String traderName;
  final List<String> requestedItems;
  final int totalKg;
  final double totalBill;
  final String status;

  OrderModel({
    required this.traderName,
    required this.requestedItems,
    required this.totalKg,
    required this.totalBill,
    required this.status,
  });
}
