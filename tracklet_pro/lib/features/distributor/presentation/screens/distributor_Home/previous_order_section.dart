import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/widgets/distributor_order_card.dart';


class PreviousOrdersSection extends StatelessWidget {
  const PreviousOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Text("Previous Orders",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Text("See all", style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 10),
        const DistributorOrderCard(
          plantName: "Tracklet.CO Gas Plant",
          driverName: "Romail Ahmed",
          status: "In Progress",
          totalKg: "225 KG",
        ),
        const SizedBox(height: 10),
        const DistributorOrderCard(
          plantName: "Arham Traders",
          driverName: "Ali Khan",
          status: "Completed",
          totalKg: "150 KG",
        ),
      ],
    );
  }
}
