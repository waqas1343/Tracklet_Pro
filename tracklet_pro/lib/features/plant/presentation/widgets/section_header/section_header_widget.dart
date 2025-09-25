import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/see_all_button/see_all_button.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeaderWidget({required this.title, this.onSeeAll, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall / 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: theme.textTheme.displaySmall),
          if (onSeeAll != null) SeeAllButton(onTap: onSeeAll!),
        ],
      ),
    );
  }
}
