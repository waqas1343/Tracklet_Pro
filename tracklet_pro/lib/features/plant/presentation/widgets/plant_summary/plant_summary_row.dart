import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/widgets/plant_summary_card/plant_summary_cards.dart';

class PlantSummaryRow extends StatelessWidget {
  const PlantSummaryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: PlantSummaryCard(
              title: "Total Gas Available",
              value: "12.5 Tons",
              bgColor: const Color(0xFF0A3161),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: PlantSummaryCard(
              title: "Active Employees",
              value: "20",
              bgColor: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: PlantSummaryCard(
              title: "Orders in Progress",
              value: "07",
              bgColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
