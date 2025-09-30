import 'package:flutter/material.dart';

class DistributorOrderCard extends StatelessWidget {
  final String plantName;
  final String driverName;
  final String status;
  final String totalKg;
  final String specialInstructions;
  final List<String> requestedItems;

  const DistributorOrderCard({
    super.key,
    required this.plantName,
    required this.driverName,
    required this.status,
    required this.totalKg,
    required this.specialInstructions,
    required this.requestedItems,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    // Responsive dimensions
    final cardPadding = screenWidth * 0.03; // 3% of screen width
    final titleFontSize = screenWidth * 0.04; // 4% of screen width
    final subtitleFontSize = screenWidth * 0.035; // 3.5% of screen width
    final statusFontSize = screenWidth * 0.03; // 3% of screen width
    final chipFontSize = screenWidth * 0.032; // 3.2% of screen width

    Color statusColor =
        status == "Completed" ? Colors.green : Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: cardPadding),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Plant Name + Status Chip
          Row(
            children: [
              Expanded(
                child: Text(
                  plantName,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: cardPadding * 0.8,
                  vertical: cardPadding * 0.3,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: statusFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: cardPadding * 0.5),

          /// Driver Name
          Text(
            "Driver Name: $driverName",
            style: TextStyle(fontSize: subtitleFontSize),
          ),
          SizedBox(height: cardPadding * 0.5),

          /// Special Instructions
          Text(
            "Special Instructions:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: subtitleFontSize,
            ),
          ),
          Text(
            specialInstructions,
            style: TextStyle(
              fontSize: subtitleFontSize * 0.95,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: cardPadding),

          /// Requested Items Chips
          Text(
            "Requested Items",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: subtitleFontSize,
            ),
          ),
          SizedBox(height: cardPadding * 0.5),
          Wrap(
            spacing: 8,
            children: requestedItems
                .map((item) => Chip(
                      label: Text(
                        item,
                        style: TextStyle(
                          fontSize: chipFontSize,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.black,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ))
                .toList(),
          ),
          SizedBox(height: cardPadding),

          /// Total KG
          Text(
            "Total KG: $totalKg",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: subtitleFontSize * 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
