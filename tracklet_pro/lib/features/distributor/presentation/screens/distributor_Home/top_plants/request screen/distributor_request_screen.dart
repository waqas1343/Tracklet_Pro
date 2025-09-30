import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/top_plants/request%20screen/provider/distributor_request_provider.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/top_plants/request%20screen/quantity_selector/quantity_selector.dart';

class DistributorRequestScreen extends StatelessWidget {
  final String plantName;
  final String plantImageUrl;

  const DistributorRequestScreen({
    super.key,
    required this.plantName,
    required this.plantImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DistributorRequestProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  plantImageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plantName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Per KG Price: Rs. ${provider.perKgPrice}",
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Select Quantity:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  ...provider.cylinderWeights.map(
                    (w) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: QuantitySelector(weight: w),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Kg:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text("${provider.totalKg} KG"),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Request Discount:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DropdownButton<int>(
                        value: provider.discount,
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Text("No Discount"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("2 pkr Per Kg"),
                          ),
                          DropdownMenuItem(
                            value: 5,
                            child: Text("5 pkr Per Kg"),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) provider.setDiscount(val);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Price:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text("${provider.totalPrice.toStringAsFixed(0)} PKR"),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "Special Instructions:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: "Please deliver after 2 PM. Handle carefully.",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Request Cylinder"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
