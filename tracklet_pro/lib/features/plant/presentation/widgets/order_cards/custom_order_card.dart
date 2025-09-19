import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';

class CustomOrderCard extends StatelessWidget {
  final String traderName;
  final String driverName;
  final List<String> items;
  final Widget? statusWidget;
  final Widget? trailingWidget;
  
  const CustomOrderCard({
    required this.traderName,
    required this.driverName,
    required this.items,
    this.statusWidget,
    this.trailingWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceDefault),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Trader and Status Row
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.darkBlue,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: AppDimensions.iconDefault,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceSmall),
                Expanded(
                  child: Text(
                    traderName, 
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (statusWidget != null) statusWidget!,
              ],
            ),
            
            // Driver Name
            const SizedBox(height: AppDimensions.spaceSmall),
            Text(
              "Driver: $driverName", 
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
            const SizedBox(height: AppDimensions.spaceSmall),
            
            // Items List
            if (items.isNotEmpty) ...[
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: items.map((item) => Container(
                    margin: const EdgeInsets.only(right: AppDimensions.spaceSmall),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingSmall,
                      vertical: AppDimensions.paddingSmall / 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.darkBlue,
                      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
                    ),
                    child: Text(
                      item, 
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
            
            // Trailing Buttons
            if (trailingWidget != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: trailingWidget,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
