import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';
import 'package:tracklet_pro/features/plant/presentation/providers/plant_summary_provider.dart';

class PlantSummaryCard extends StatelessWidget {
  final String titleLine1;
  final String titleLine2;
  final String value;
  final IconData icon;
  final Color bgColor;
  final Color? textColor;
  final VoidCallback? onInfoTap;
  final String cardId;
  final bool isSelected;

  const PlantSummaryCard({
    required this.titleLine1,
    required this.titleLine2,
    required this.value,
    required this.icon,
    required this.cardId,
    this.bgColor = const Color(0xFF0A3161),
    this.textColor,
    this.onInfoTap,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<PlantSummaryProvider>(context, listen: true);
    final isCardSelected = provider.isCardSelected(cardId);

    // Text color: white when selected, dark blue when not selected
    final Color textColor = isCardSelected ? Colors.white : AppColors.darkBlue;

    // Background color: dark blue when selected, white when not selected
    final Color backgroundColor = isCardSelected
        ? AppColors.darkBlue
        : Colors.white;

    return GestureDetector(
      onTap: () => provider.selectCard(cardId),
      child: SizedBox(
        height: 120,
        child: Card(
          elevation: isCardSelected ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusDefault,
            ),
            side: BorderSide(
              color: isCardSelected ? AppColors.darkBlue : Colors.grey[300]!,
              width: isCardSelected ? 1.5 : 1,
            ),
          ),
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleLine1,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            titleLine2,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isCardSelected
                                  ? Colors.white70
                                  : AppColors.darkGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isCardSelected
                            ? Colors.white24
                            : Colors.grey[200]!,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        size: AppDimensions.iconSmall,
                        color: isCardSelected
                            ? Colors.white
                            : AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (onInfoTap != null)
                      GestureDetector(
                        onTap: onInfoTap,
                        child: Icon(
                          Icons.info_outline,
                          size: 16,
                          color: isCardSelected
                              ? Colors.white70
                              : AppColors.darkGrey,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
