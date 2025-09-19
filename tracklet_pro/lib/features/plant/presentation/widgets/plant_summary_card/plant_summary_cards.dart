import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';

class PlantSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color bgColor;
  final VoidCallback? onInfoTap;

  const PlantSummaryCard({
    required this.title,
    required this.value,
    this.bgColor = const Color(0xFF0A3161),
    this.onInfoTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = bgColor == AppColors.white;
    
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingSmall / 2),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: isDark ? AppColors.darkGrey : Colors.white70,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppDimensions.paddingSmall / 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isDark ? AppColors.darkBlue : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.fontLarge,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onInfoTap != null) ...[
                  const SizedBox(width: AppDimensions.paddingSmall / 2),
                  GestureDetector(
                    onTap: onInfoTap,
                    child: Icon(
                      Icons.info_outline,
                      color: isDark ? AppColors.darkGrey.withOpacity(0.7) : Colors.white70,
                      size: AppDimensions.iconSmall,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
