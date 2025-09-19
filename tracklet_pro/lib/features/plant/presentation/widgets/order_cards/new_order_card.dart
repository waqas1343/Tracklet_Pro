import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class NewOrderCard extends StatelessWidget {
  final String traderName;
  final String traderTitle;
  final String driverName;
  final List<String> items;
  final VoidCallback? onApprove;
  final VoidCallback? onCancel;

  const NewOrderCard({
    required this.traderName,
    required this.traderTitle,
    required this.driverName,
    required this.items,
    this.onApprove,
    this.onCancel,
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
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusLarge - 2,
          ),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Trader Info with Profile Image on Right
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          traderName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          traderTitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Profile Image
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.brown.shade200,
                        width: 1.5,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://randomuser.me/api/portraits/men/1.jpg', // Placeholder image URL
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Driver Info
              Text(
                'Driver: $driverName',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
              const SizedBox(height: 16),

              // Requested Items Heading
              Text(
                'Requested Items:',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              // Items Chips
              if (items.isNotEmpty) _buildItemsList(),
              const SizedBox(height: 16),

              // Action Buttons
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildItemsList() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.darkBlue,
                borderRadius: BorderRadius.circular(16),
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
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          borderRadius: 50,
          width: 140,
          height: 40,
          text: "Cancel",
          onPressed: onCancel ?? () {},
          backgroundColor: AppColors.darkBlue,
          textColor: Colors.white,
          isEnabled: onCancel != null,
        ),
        const SizedBox(width: 12),
        CustomButton(
          borderRadius: 50,

          width: 140,
          height: 40,
          text: "Approve",
          backgroundColor: AppColors.darkBlue,

          onPressed: onApprove ?? () {},
          textColor: Colors.white,
          isEnabled: onApprove != null,
        ),
      ],
    );
  }
}
