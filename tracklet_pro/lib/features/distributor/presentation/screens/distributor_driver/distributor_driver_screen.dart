import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_driver/distributor_driver_card.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import 'package:tracklet_pro/shared/widgets/custom_textfield.dart';

class DistributorDriverScreen extends StatelessWidget {
  final List<Map<String, dynamic>> drivers = [
    {
      "name": "Ahmed Khan",
      "status": "Available",
      "description": "Experienced driver with ",
      "showAvatar": false,
    },
    {
      "name": "Usman Ali",
      "status": "On Delivery",
      "description": "Reliable and punctual driver",
      "showAvatar": false,
    },
    {
      "name": "Hassan Raza",
      "status": "Available",
      "description": "Professional delivery specialist",
      "showAvatar": true,
    },
  ];

  DistributorDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Drivers",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text("Add Driver"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomTextField(
                hintText: "Search drivers...",
                onChanged: (value) {},
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  final driver = drivers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: DistributorDriverCard(
                      name: driver["name"] ?? "Unknown Driver",
                      status: driver["status"] ?? "Unknown",
                      description:
                          driver["description"] ?? "No description available",
                      showAvatar: driver["showAvatar"] ?? false,
                      onTap: () {
                        // Handle driver selection
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
