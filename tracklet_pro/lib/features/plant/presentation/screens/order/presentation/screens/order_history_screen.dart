import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/presentation/widgets/orders_tabs.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import '../provider/order_provider.dart';
import '../widgets/order_card.dart';
import '../widgets/profile_header.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ProfileHeader(),
                const SizedBox(height: 20),
                OrdersTabs(),

                const SizedBox(height: 20),
                Expanded(
                  child: provider.orders.isEmpty
                      ? Center(
                          child: Text(
                            provider.isCompletedTab
                                ? 'No completed orders yet'
                                : 'No cancelled orders yet',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : ListView.separated(
                          itemCount: provider.orders.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return OrderCard(order: provider.orders[index]);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
