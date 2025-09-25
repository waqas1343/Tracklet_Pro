import 'package:flutter/foundation.dart';

/// Provider for managing stock data and state
class StockProvider extends ChangeNotifier {
  List<StockItem> _stockItems = [];
  bool _isLoading = false;
  String _selectedFilter = 'All';
  String _searchQuery = '';

  // Getters
  List<StockItem> get stockItems => _stockItems;
  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;
  String get searchQuery => _searchQuery;

  // Filtered stock items based on filter and search
  List<StockItem> get filteredStockItems {
    var filtered = _stockItems;

    // Apply filter
    if (_selectedFilter != 'All') {
      filtered = filtered.where((item) => item.category == _selectedFilter).toList();
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
        item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        item.id.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  /// Load stock items from data source
  Future<void> loadStockItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call or database fetch
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data - replace with actual data fetching
      _stockItems = [
        StockItem(
          id: 'STK001',
          name: '50 KG Cylinder',
          category: 'Large',
          quantity: 25,
          minThreshold: 5,
          maxCapacity: 50,
          location: 'Warehouse A',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        StockItem(
          id: 'STK002',
          name: '30 KG Cylinder',
          category: 'Medium',
          quantity: 40,
          minThreshold: 10,
          maxCapacity: 60,
          location: 'Warehouse A',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 4)),
        ),
        StockItem(
          id: 'STK003',
          name: '15 KG Cylinder',
          category: 'Small',
          quantity: 15,
          minThreshold: 8,
          maxCapacity: 30,
          location: 'Warehouse B',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 6)),
        ),
        StockItem(
          id: 'STK004',
          name: '10 KG Cylinder',
          category: 'Small',
          quantity: 5,
          minThreshold: 10,
          maxCapacity: 25,
          location: 'Warehouse B',
          lastUpdated: DateTime.now().subtract(const Duration(hours: 8)),
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Failed to load stock items: $e');
    }
  }

  /// Set filter for stock items
  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  /// Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Add new stock item
  void addStockItem(StockItem item) {
    _stockItems.add(item);
    notifyListeners();
  }

  /// Update stock quantity
  void updateStockQuantity(String itemId, int newQuantity) {
    final index = _stockItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _stockItems[index] = _stockItems[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  /// Update stock item location
  void updateStockLocation(String itemId, String newLocation) {
    final index = _stockItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _stockItems[index] = _stockItems[index].copyWith(location: newLocation);
      notifyListeners();
    }
  }

  /// Delete stock item
  void deleteStockItem(String itemId) {
    _stockItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  /// Get low stock items (below minimum threshold)
  List<StockItem> get lowStockItems {
    return _stockItems.where((item) => item.quantity <= item.minThreshold).toList();
  }

  /// Get stock summary by category
  Map<String, int> getStockSummaryByCategory() {
    final summary = <String, int>{};
    for (var item in _stockItems) {
      summary[item.category] = (summary[item.category] ?? 0) + item.quantity;
    }
    return summary;
  }

  /// Get total stock value (if price is available)
  double get totalStockValue {
    // Assuming each cylinder has a base price - replace with actual pricing logic
    const double basePricePerCylinder = 5000.0;
    return _stockItems.fold(0.0, (sum, item) => sum + (item.quantity * basePricePerCylinder));
  }
}

/// Stock item model class
class StockItem {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final int minThreshold;
  final int maxCapacity;
  final String location;
  final DateTime lastUpdated;

  const StockItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.minThreshold,
    required this.maxCapacity,
    required this.location,
    required this.lastUpdated,
  });

  StockItem copyWith({
    String? id,
    String? name,
    String? category,
    int? quantity,
    int? minThreshold,
    int? maxCapacity,
    String? location,
    DateTime? lastUpdated,
  }) {
    return StockItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      minThreshold: minThreshold ?? this.minThreshold,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      location: location ?? this.location,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Check if stock is low
  bool get isLowStock => quantity <= minThreshold;

  /// Get stock level percentage
  double get stockLevelPercentage => (quantity / maxCapacity) * 100;

  @override
  String toString() {
    return 'StockItem(id: $id, name: $name, quantity: $quantity, location: $location)';
  }
}
