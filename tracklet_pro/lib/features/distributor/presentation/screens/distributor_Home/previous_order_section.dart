import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/widgets/distributor_order_card.dart';

class PreviousOrdersSection extends StatelessWidget {
  const PreviousOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    // Responsive dimensions
    final titleFontSize = screenWidth * 0.045; // 4.5% of screen width

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Previous Orders",
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "See all",
              style: TextStyle(
                color: Colors.blue,
                fontSize: titleFontSize * 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        DistributorOrderCard(
          plantName: "Tracklet.CO Gas Plant",
          driverName: "Romail Ahmed",
          status: "In Progress",
          totalKg: "225 KG",
          specialInstructions:
              "Please deliver after 2 PM. Handle cylinders carefully.",
          requestedItems: ["45.4 KG (3)", "15 KG (5)"],
        ),

        const SizedBox(height: 10),
        DistributorOrderCard(
          plantName: "Tracklet.CO Gas Plant",
          driverName: "Romail Ahmed",
          status: "In Progress",
          totalKg: "225 KG",
          specialInstructions:
              "Please deliver after 2 PM. Handle cylinders carefully.",
          requestedItems: ["45.4 KG (3)", "15 KG (5)"],
        ),
      ],
    );
  }
}
