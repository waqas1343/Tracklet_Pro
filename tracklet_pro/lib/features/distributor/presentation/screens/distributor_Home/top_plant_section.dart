import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/widgets/plant_card.dart';

class TopPlantsSection extends StatelessWidget {
  const TopPlantsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: Text(
                "Top Plants",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Text("See all", style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              PlantCard(
                imageUrl:
                    "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop",
                title: "Gas Plant Structure",
                price: "Rs. 250",
              ),
              PlantCard(
                imageUrl:
                    "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop",
                title: "Industrial Building",
                price: "Rs. 270",
              ),
              PlantCard(
                imageUrl:
                    "https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=400&h=300&fit=crop",
                title: "Plant Architecture",
                price: "Rs. 280",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
