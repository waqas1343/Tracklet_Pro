import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/assets/app_icons.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/presentation/providers/plant_summary_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/plant_summary_card/plant_summary_cards.dart';

class PlantSummaryRow extends StatelessWidget {
  const PlantSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantSummaryProvider>(
      builder: (context, provider, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = (constraints.maxWidth - 16) / 3;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: PlantSummaryCard(
                    cardId: 'gas_available',
                    titleLine1: "Total",
                    titleLine2: "Gas Available",
                    value: "12.5 Tons",
                    iconPath: AppIcons.totalEmployees,
                    bgColor: const Color(0xFF0A3161),
                    isSelected: provider.isCardSelected('gas_available'),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: PlantSummaryCard(
                    cardId: 'active_employees',
                    titleLine1: "Active",
                    titleLine2: "Employees",
                    value: "20",
                    iconPath: AppIcons.totalEmployees,
                    bgColor: AppColors.white,
                    isSelected: provider.isCardSelected('active_employees'),
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: PlantSummaryCard(
                    cardId: 'orders_in_progress',
                    titleLine1: "Orders",
                    titleLine2: "in Progress",
                    value: "07",
                    iconPath: AppIcons.totalEmployees,
                    bgColor: const Color(0xFFF0F4F8),
                    isSelected: provider.isCardSelected('orders_in_progress'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
