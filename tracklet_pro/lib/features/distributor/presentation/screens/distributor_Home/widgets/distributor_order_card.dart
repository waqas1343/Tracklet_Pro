import 'package:flutter/material.dart';

class DistributorOrderCard extends StatelessWidget {
  final String plantName;
  final String driverName;
  final String status;
  final String totalKg;

  const DistributorOrderCard({
    super.key,
    required this.plantName,
    required this.driverName,
    required this.status,
    required this.totalKg,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor =
        status == "Completed" ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(plantName,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status,
                    style: TextStyle(color: statusColor, fontSize: 12)),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text("Driver Name: $driverName"),
          const SizedBox(height: 6),
          Text("Total KG: $totalKg",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
