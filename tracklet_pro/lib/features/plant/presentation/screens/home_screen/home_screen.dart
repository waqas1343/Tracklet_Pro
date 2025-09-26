import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/plant_summary/plant_summary_row.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/order_cards/new_order_card.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/order_cards/previous_order_card.dart';
import 'package:tracklet_pro/features/plant/presentation/widgets/section_header/section_header_widget.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimensions.paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionHeaderWidget(title: "Plant Summary", onSeeAll: () {}),
              const SizedBox(height: AppDimensions.spaceDefault),
              const PlantSummaryRow(),
              const SizedBox(height: AppDimensions.paddingDefault * 1.5),
              SectionHeaderWidget(title: "New Orders", onSeeAll: () {}),
              const SizedBox(height: 8),
              const NewOrderCard(
                traderName: "Arham Traders",
                traderTitle:
                    "Arham Traders placed a request for\nmentioned cylinders",
                driverName: "Romail Ahmed",
                specialInstructor: "John Doe", // Added special instructor
                items: ["50 KG (3)", "15 KG (5)"],
                totalKg: "150 KG",
              ),
              const SizedBox(height: AppDimensions.paddingDefault * 1.5),

              // Previous Orders Section
              SectionHeaderWidget(title: "Previous Orders", onSeeAll: () {}),
              const SizedBox(height: 12),
              const PreviousOrderCard(
                traderName: "Arham Traders",
                driverName: "Romail Ahmed",
                items: ["50 KG (3)", "15 KG (5)"],
                status: "Completed",
                statusColor: AppColors.successColor,
              ),
              const SizedBox(height: 12),
              const PreviousOrderCard(
                traderName: "Arham Traders",
                driverName: "Romail Ahmed",
                items: ["50 KG (3)", "15 KG (5)"],
                status: "Cancelled",
                statusColor: AppColors.errorColor,
              ),
              const SizedBox(
                height: 24,
              ), // Add bottom padding for better scrolling
            ],
          ),
        ),
      ),
    );
  }
}
