import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/previous_order_section.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/top_plant_section.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import 'package:tracklet_pro/shared/widgets/custom_textfield.dart';

class DistributorHomeScreen extends StatelessWidget {
  const DistributorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(hintText: 'Search', suffixIcon: Icon(Icons.search)),
            const SizedBox(height: 10),
            const TopPlantsSection(),
            SizedBox(height: 10),
            const PreviousOrdersSection(),
          ],
        ),
      ),
    );
  }
}
