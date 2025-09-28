import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/order/presentation/widgets/orders_tabs.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import '../provider/order_provider.dart';
import '../widgets/order_card.dart';
import '../widgets/profile_header.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvidermain>(
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
                  child: ListView.builder(
                    itemCount: provider.orders.length,
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
