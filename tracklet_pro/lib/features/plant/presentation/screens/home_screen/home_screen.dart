import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';
import 'package:tracklet_pro/features/plant/presentation/widgets/order_cards/custom_order_card.dart';
import 'package:tracklet_pro/features/plant/presentation/widgets/plant_summary/plant_summary_row.dart';
import 'package:tracklet_pro/features/plant/presentation/widgets/section_header/section_header_widget.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingDefault),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SectionHeaderWidget(
                    title: "Plant Summary", 
                    onSeeAll: () {}
                  ),
                  const SizedBox(height: AppDimensions.spaceDefault),
                  const PlantSummaryRow(),
                  const SizedBox(height: AppDimensions.paddingDefault * 1.5),
                  SectionHeaderWidget(
                    title: "New Orders", 
                    onSeeAll: () {}
                  ),
                  const SizedBox(height: 12),
                  CustomOrderCard(
                    traderName: "Arham Traders",
                    driverName: "Romail Ahmed",
                    items: ["50 KG (3)", "15 KG (5)"],
                    trailingWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: CustomButton(
                            text: "Cancel",
                            onPressed: () {
                              // Cancel action
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: CustomButton(
                            text: "Approve",
                            onPressed: () {
                              // Approve action
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingDefault * 1.5),

                  // Previous Orders Section
                  SectionHeaderWidget(
                    title: "Previous Orders",
                    onSeeAll: () {
                      // Handle See all tap here
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomOrderCard(
                    traderName: "Arham Traders",
                    driverName: "Romail Ahmed",
                    items: ["50 KG (3)", "15 KG (5)"],
                    statusWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Completed",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomOrderCard(
                    traderName: "Arham Traders",
                    driverName: "Romail Ahmed",
                    items: ["50 KG (3)", "15 KG (5)"],
                    statusWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
