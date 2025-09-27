import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/rates/presentation/provider/order_provider.dart';
import 'package:tracklet_pro/features/rates/presentation/widgets/order_tab_button.dart';

class OrdersTabs extends StatelessWidget {
  const OrdersTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderProvidermain>();
    return Row(
      children: [
        OrderTabButton(
          text: "Completed",
          isActive: provider.isCompletedTab,
          onTap: () => provider.switchTab(true),
        ),
        const SizedBox(width: 10),
        OrderTabButton(
          text: "Cancelled",
          isActive: !provider.isCompletedTab,
          onTap: () => provider.switchTab(false),
        ),
      ],
    );
  }
}
