import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/order/data/model/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
     border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  order.traderName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Chip(
                  backgroundColor: Colors.green,
                  label: Text(order.status))
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("Requested item "),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                      backgroundColor: Colors.black,
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
                Text("Total Kg:"),
                Text("Rs. ${order.totalKg}"),
              ],
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Bill:"),
                Text("Rs. ${order.totalBill}"),
              ],
            ),
         
          
          ],
        ),
      ),
    );
  }
}
