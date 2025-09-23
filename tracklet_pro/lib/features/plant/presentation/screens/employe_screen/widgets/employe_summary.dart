import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';

class EmployeeSummary extends StatelessWidget {
  const EmployeeSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading + Add Leave Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Employee Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {},
              child: const Text("Add Leave"),
            )
          ],
        ),
        const SizedBox(height: 12),

        // Add Employee Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            child: const Text("Add Employee"),
          ),
        ),
        const SizedBox(height: 16),

        // Summary Cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCard("Total Employees", provider.totalEmployees.toString(),
                Colors.blue),
            _buildCard("Present Today", provider.presentCount.toString(),
                Colors.green),
            _buildCard("Absent Today", provider.absentCount.toString(),
                Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(String title, String value, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Column(
        children: [
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
