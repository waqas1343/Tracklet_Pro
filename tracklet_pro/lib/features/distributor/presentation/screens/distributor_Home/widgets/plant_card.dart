import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/top_plants/request%20screen/distributor_request_screen.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class PlantCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const PlantCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    // Responsive card width - approximately 45% of screen width, but not more than 200
    final cardWidth = (screenWidth * 0.45).clamp(140.0, 200.0);

    return Container(
      padding: const EdgeInsets.all(4.0),
      width: cardWidth,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: cardWidth * 0.6,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  "Per KG Price: $price",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  text: "Request",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DistributorRequestScreen(
                          plantName: title,
                          plantImageUrl: imageUrl,
                        ),
                      ),
                    );
                  },
                  height: 35,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
