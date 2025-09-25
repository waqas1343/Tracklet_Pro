// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/orders_screen/provider/orders_provider.dart';
import 'package:tracklet_pro/shared/widgets/loading_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrdersProvider>(
      create: (context) => OrdersProvider()..loadOrders(),
      child: const _OrdersContent(),
    );
  }
}

class _OrdersContent extends StatelessWidget {
  const _OrdersContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: AppColors.darkBlue,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Consumer<OrdersProvider>(
        builder: (context, ordersProvider, _) {
          if (ordersProvider.isLoading) {
            return const Center(
              child: LoadingIndicator(
                color: AppColors.darkBlue,
                isLarge: true,
              ),
            );
          }

          final orders = ordersProvider.filteredOrders;

          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _OrderCard(order: order);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'orders_fab', // Unique hero tag
        onPressed: () => _showAddOrderDialog(context),
        backgroundColor: AppColors.darkBlue,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final ordersProvider = context.read<OrdersProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Orders'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('All Orders'),
              value: 'All',
              groupValue: ordersProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  ordersProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Completed'),
              value: 'Completed',
              groupValue: ordersProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  ordersProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('In Progress'),
              value: 'In Progress',
              groupValue: ordersProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  ordersProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Cancelled'),
              value: 'Cancelled',
              groupValue: ordersProvider.selectedFilter,
              onChanged: (value) {
                if (value != null) {
                  ordersProvider.setFilter(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Order'),
        content: const Text('Add order form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add order logic here
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

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

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
                Text(
                  'Order ${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _StatusChip(status: order.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Customer: ${order.customerName}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Items: ${order.items.join(', ')}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ) ?? TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: PKR ${order.totalAmount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ) ?? TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  '${order.date.day}/${order.date.month}/${order.date.year}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ) ?? TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (order.status == 'In Progress')
                  TextButton(
                    onPressed: () => _showUpdateStatusDialog(context, order),
                    child: const Text('Update Status'),
                  ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showOrderDetails(context),
                  icon: const Icon(Icons.visibility),
                  tooltip: 'View Details',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(BuildContext context, Order order) {
    final ordersProvider = context.read<OrdersProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Order Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Completed'),
              value: 'Completed',
              groupValue: order.status,
              onChanged: (value) {
                if (value != null) {
                  ordersProvider.updateOrderStatus(order.id, value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('Cancelled'),
              value: 'Cancelled',
              groupValue: order.status,
              onChanged: (value) {
                if (value != null) {
                  ordersProvider.updateOrderStatus(order.id, value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Details'),
        content: Text('Order details for ${order.id} will be shown here.'),
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

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  Color _getStatusColor(BuildContext context) {
    switch (status) {
      case 'Completed':
        return AppColors.successColor;
      case 'In Progress':
        return Theme.of(context).colorScheme.primary;
      case 'Cancelled':
        return AppColors.errorColor;
      default:
        return Theme.of(context).colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
