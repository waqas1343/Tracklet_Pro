import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(order.traderName, style: textTheme.titleLarge),
                const Spacer(),
                Chip(
                  label: Text(order.status),
                  backgroundColor: scheme.primaryContainer,
                  labelStyle: textTheme.labelSmall,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                )
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Requested item', style: textTheme.bodyMedium),
                Wrap(
              spacing: 2,
              children: order.requestedItems
                  .map(
                    (e) => Chip(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: -2),
                      label: Text(
                        e,
                        style: TextStyle(
                          color: scheme.onSecondaryContainer,
                          fontSize: 10,
                        ),
                      ),
                      backgroundColor: scheme.secondaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide.none,
                      ),
                    ),
                  )
                  .toList(),
                  
            ),
            

              ],
            ),
          
            const SizedBox(height: 6),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Kg:', style: textTheme.bodyMedium),
                Text('Rs. ${order.totalKg}', style: textTheme.titleMedium),
              ],
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Bill:', style: textTheme.bodyMedium),
                Text('Rs. ${order.totalBill}', style: textTheme.titleMedium),
              ],
            ),
         
          
          ],
        ),
      ),
    );
  }
}
