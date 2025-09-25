import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';

class PreviousOrderCard extends StatelessWidget {
  final String traderName;
  final String driverName;
  final List<String> items;
  final String status;
  final Color statusColor;

  const PreviousOrderCard({
    required this.traderName,
    required this.driverName,
    required this.items,
    required this.status,
    this.statusColor = Colors.green,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.brown.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceDefault),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge - 2),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              const SizedBox(height: AppDimensions.spaceSmall),
              _buildDriverInfo(context),
              const SizedBox(height: AppDimensions.spaceSmall),
              _buildStatusBadge(),
              if (items.isNotEmpty) _buildItemsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          traderName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        const CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.darkBlue,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: AppDimensions.iconDefault,
          ),
        ),
      ],
    );
  }

  Widget _buildDriverInfo(BuildContext context) {
    return Text(
      "Driver: $driverName",
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).hintColor,
          ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map(
              (item) => Container(
                margin: const EdgeInsets.only(
                  right: AppDimensions.spaceSmall,
                  top: AppDimensions.spaceSmall,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSmall,
                  vertical: AppDimensions.paddingSmall / 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkBlue,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusDefault,
                  ),
                ),
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
