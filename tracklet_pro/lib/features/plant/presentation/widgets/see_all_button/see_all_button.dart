import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';

class SeeAllButton extends StatelessWidget {
  final VoidCallback onTap;

  const SeeAllButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: AppColors.lightBlueBackground,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.only(
            right: AppDimensions.borderRadiusNormal,
            left: AppDimensions.borderRadiusNormal,
            bottom: AppDimensions.borderRadiusExtra,
            top: AppDimensions.borderRadiusExtra,
          ),
          child: Text("See all", style: theme.textTheme.bodyLarge),
        ),
      ),
    );
  }
}
