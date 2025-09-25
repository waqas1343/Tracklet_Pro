import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/rates_screen/provider/rate_provider/rate_provider.dart';

class RateHistoryListWidget extends StatelessWidget {
  const RateHistoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RateProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "Total Sales (KG)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "Rate per KG",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        Column(
          children: provider.filteredHistory.map((item) {
            return Container(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item["date"].toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    item["sales"].toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "PKR ${item["rate"]}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        if (provider.searchQuery.isNotEmpty ||
            provider.selectedMonth.isNotEmpty ||
            provider.selectedRate.isNotEmpty)
          Center(
            child: ElevatedButton.icon(
              onPressed: () => provider.clearFilters(),
              icon: const Icon(Icons.clear),
              label: const Text("Clear Filters"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black87,
              ),
            ),
          ),
      ],
    );
  }
}
