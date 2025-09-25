import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/assets/app_icons.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/presentation/providers/plant_summary_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/widgets/summary_tab/summary_tab.dart';

class PlantSummaryRow extends StatelessWidget {
  const PlantSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlantSummaryProvider>(context, listen: true);

    return Row(
      children: [
        Expanded(
          child: SummaryTab(
            value: '12.5',
            label: 'Tons',
            iconPath: AppIcons.totalEmployees,
            color: const Color(0xFF0A3161),
            isSelected: provider.isCardSelected('gas_available'),
            onTap: () => provider.selectCard('gas_available'),
            headerTop: 'Total',
            headerBottom: 'Gas Available',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SummaryTab(
            value: '20',
            label: 'Active',
            iconPath: AppIcons.totalEmployees,
            color: AppColors.mediumBlue,
            isSelected: provider.isCardSelected('active_employees'),
            onTap: () {
              provider.selectCard('active_employees');
              Navigator.pushNamed(context, '/employee');
            },
            headerTop: 'Active',
            headerBottom: 'Employees',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SummaryTab(
            value: '07',
            label: 'Orders',
            iconPath: AppIcons.totalEmployees,
            color: AppColors.mediumBlue,
            isSelected: provider.isCardSelected('orders_in_progress'),
            onTap: () => provider.selectCard('orders_in_progress'),
            headerTop: 'Orders',
            headerBottom: 'in Progress',
          ),
        ),
      ],
    );
  }
}
