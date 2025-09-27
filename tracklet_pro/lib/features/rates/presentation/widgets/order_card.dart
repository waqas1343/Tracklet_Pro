import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/rates/data/model/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.traderName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: order.requestedItems
                  .map(
                    (e) => Chip(
                      label: Text(
                        e,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 6),
            Text("Total Kg: ${order.totalKg} KG"),
            Text("Total Bill: Rs. ${order.totalBill}"),
            Align(
              alignment: Alignment.bottomRight,
              child: Chip(
                label: Text(
                  order.status,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
