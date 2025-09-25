// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/stock_screen/provider/stock_provider.dart';
import 'package:tracklet_pro/shared/widgets/loading_indicator.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StockProvider>(
      create: (context) => StockProvider()..loadStockItems(),
      child: const _StockContent(),
    );
  }
}

class _StockContent extends StatelessWidget {
  const _StockContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Management'),
        backgroundColor: AppColors.darkBlue,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Consumer<StockProvider>(
        builder: (context, stockProvider, _) {
          if (stockProvider.isLoading) {
            return const Center(
              child: LoadingIndicator(
                color: AppColors.darkBlue,
                isLarge: true,
              ),
            );
          }

          final stockItems = stockProvider.filteredStockItems;
          final lowStockItems = stockProvider.lowStockItems;

          return Column(
            children: [
              if (lowStockItems.isNotEmpty)
                _LowStockAlert(lowStockCount: lowStockItems.length),
              Expanded(
                child: stockItems.isEmpty
                    ? const Center(
                        child: Text('No stock items found'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: stockItems.length,
                        itemBuilder: (context, index) {
                          final item = stockItems[index];
                          return _StockCard(stockItem: item);
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'stock_fab', // Unique hero tag
        onPressed: () => _showAddStockDialog(context),
        backgroundColor: AppColors.darkBlue,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final stockProvider = context.read<StockProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Stock'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Search by name or ID...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            stockProvider.setSearchQuery(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              stockProvider.setSearchQuery('');
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final stockProvider = context.read<StockProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Stock'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('All Items'),
              value: 'All',
              groupValue: stockProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  stockProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Large Cylinders'),
              value: 'Large',
              groupValue: stockProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  stockProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Medium Cylinders'),
              value: 'Medium',
              groupValue: stockProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  stockProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Small Cylinders'),
              value: 'Small',
              groupValue: stockProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  stockProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddStockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Stock Item'),
        content: const Text('Add stock item functionality will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add stock item logic here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _LowStockAlert extends StatelessWidget {
  final int lowStockCount;

  const _LowStockAlert({required this.lowStockCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.error),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Theme.of(context).colorScheme.error),
          const SizedBox(width: 8),
          Text(
            '$lowStockCount items are running low on stock!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.bold,
            ) ?? TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StockCard extends StatelessWidget {
  final StockItem stockItem;

  const _StockCard({required this.stockItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stockItem.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID: ${stockItem.id}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ) ?? TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                _StockLevelIndicator(stockItem: stockItem),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity: ${stockItem.quantity}/${stockItem.maxCapacity}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Location: ${stockItem.location}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ) ?? TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      stockItem.category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ) ?? TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Min: ${stockItem.minThreshold}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ) ?? TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last Updated: ${stockItem.lastUpdated.day}/${stockItem.lastUpdated.month}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ) ?? TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _showUpdateQuantityDialog(context, stockItem),
                      icon: const Icon(Icons.edit),
                      tooltip: 'Update Quantity',
                    ),
                    IconButton(
                      onPressed: () => _showStockDetails(context),
                      icon: const Icon(Icons.visibility),
                      tooltip: 'View Details',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateQuantityDialog(BuildContext context, StockItem stockItem) {
    final stockProvider = context.read<StockProvider>();
    final controller = TextEditingController(text: stockItem.quantity.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Stock Quantity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'New Quantity',
                border: const OutlineInputBorder(),
                hintText: 'Enter quantity (0-${stockItem.maxCapacity})',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current: ${stockItem.quantity} | Max: ${stockItem.maxCapacity}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ) ?? TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newQuantity = int.tryParse(controller.text);
              if (newQuantity != null &&
                  newQuantity >= 0 &&
                  newQuantity <= stockItem.maxCapacity) {
                stockProvider.updateStockQuantity(stockItem.id, newQuantity);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showStockDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stock Details'),
        content: Text('Stock details for ${stockItem.name} will be shown here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _StockLevelIndicator extends StatelessWidget {
  final StockItem stockItem;

  const _StockLevelIndicator({required this.stockItem});

  @override
  Widget build(BuildContext context) {
    final percentage = stockItem.stockLevelPercentage;
    final isLowStock = stockItem.isLowStock;

    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isLowStock ? Theme.of(context).colorScheme.error.withValues(alpha: 0.1) : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            border: Border.all(
              color: isLowStock ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              '${percentage.toStringAsFixed(0)}%',
              style: TextStyle(
                color: isLowStock ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isLowStock ? 'Low Stock' : 'In Stock',
          style: TextStyle(
            fontSize: 10,
            color: isLowStock ? Theme.of(context).colorScheme.error : AppColors.successColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
