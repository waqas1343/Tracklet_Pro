import 'package:flutter/material.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';

class PlantHomeScreen extends StatelessWidget {
  const PlantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: const Center(child: Text('Plant Home Content')),
    );
  }
}
