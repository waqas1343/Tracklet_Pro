import 'package:flutter/foundation.dart';

/// Provider for managing orders data and state
class OrdersProvider extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String _selectedFilter = 'All';

  // Getters
  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;

  // Filtered orders based on selected filter
  List<Order> get filteredOrders {
    if (_selectedFilter == 'All') return _orders;
    return _orders.where((order) => order.status == _selectedFilter).toList();
  }

  /// Load orders from data source
  Future<void> loadOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call or database fetch
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data - replace with actual data fetching
      _orders = [
        Order(
          id: 'ORD001',
          customerName: 'Arham Traders',
          items: ['50 KG (3)', '15 KG (5)'],
          totalAmount: 45000,
          status: 'Completed',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Order(
          id: 'ORD002',
          customerName: 'Al-Rahim Traders',
          items: ['30 KG (2)', '10 KG (3)'],
          totalAmount: 28000,
          status: 'In Progress',
          date: DateTime.now(),
        ),
        Order(
          id: 'ORD003',
          customerName: 'Karachi Gas',
          items: ['25 KG (4)'],
          totalAmount: 15000,
          status: 'Cancelled',
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load orders: $e');
    }
  }

  /// Set filter for orders
  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  /// Add new order
  void addOrder(Order order) {
    _orders.insert(0, order); // Add to beginning of list
    notifyListeners();
  }

  /// Update order status
  void updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  /// Delete order
  void deleteOrder(String orderId) {
    _orders.removeWhere((order) => order.id == orderId);
    notifyListeners();
  }

  /// Get orders count by status
  Map<String, int> getOrdersCountByStatus() {
    final counts = <String, int>{};
    for (var order in _orders) {
      counts[order.status] = (counts[order.status] ?? 0) + 1;
    }
    return counts;
  }
}

/// Order model class
class Order {
  final String id;
  final String customerName;
  final List<String> items;
  final double totalAmount;
  final String status;
  final DateTime date;

  const Order({
    required this.id,
    required this.customerName,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.date,
  });

  Order copyWith({
    String? id,
    String? customerName,
    List<String>? items,
    double? totalAmount,
    String? status,
    DateTime? date,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Order(id: $id, customerName: $customerName, totalAmount: $totalAmount, status: $status)';
  }
}
