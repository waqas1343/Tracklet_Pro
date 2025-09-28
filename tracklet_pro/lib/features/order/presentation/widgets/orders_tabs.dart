import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/order/presentation/provider/order_provider.dart';
import 'package:tracklet_pro/features/order/presentation/widgets/completed_tab_button.dart';
import 'package:tracklet_pro/features/order/presentation/widgets/cancelled_tab_button.dart';

class OrdersTabs extends StatelessWidget {
  const OrdersTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OrderProvidermain>();
    return Row(
      children: [
        CompletedTabButton(
          isActive: provider.isCompletedTab,
          onTap: () => provider.switchTab(true),
        ),
        const SizedBox(width: 10),
        CancelledTabButton(
          isActive: !provider.isCompletedTab,
          onTap: () => provider.switchTab(false),
        ),
      ],
    );
  }
}
