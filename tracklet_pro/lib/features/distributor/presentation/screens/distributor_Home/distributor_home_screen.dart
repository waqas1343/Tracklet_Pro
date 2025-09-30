import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/previous_order_section.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/top_plants/top_plant_section.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import 'package:tracklet_pro/shared/widgets/custom_textfield.dart';

class DistributorHomeScreen extends StatelessWidget {
  const DistributorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Responsive padding based on screen size
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final verticalSpacing = screenHeight * 0.015; // 1.5% of screen height

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 8.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
              SizedBox(height: verticalSpacing),
              const TopPlantsSection(),
              SizedBox(height: verticalSpacing),
              const PreviousOrdersSection(),
            ],
          ),
        ),
      ),
    );
  }
}
