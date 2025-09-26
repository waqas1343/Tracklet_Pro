import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';

class NewOrderCard extends StatelessWidget {
  final String traderName;
  final String traderTitle;
  final String driverName;
  final String specialInstructor;
  final List<String> items;
  final String totalKg;
  final VoidCallback? onApprove;
  final VoidCallback? onCancel;

  const NewOrderCard({
    required this.traderName,
    required this.traderTitle,
    required this.driverName,
    required this.specialInstructor,
    required this.items,
    required this.totalKg,
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
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.borderRadiusNormal),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            Text(
              'Driver: $driverName',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Special Instructor: $specialInstructor',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Requested Items:',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            if (items.isNotEmpty) _buildItemsList(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total KG:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  totalKg,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
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

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildButton(
          context: context,
          text: 'Cancel',
          backgroundColor: Colors.red.shade600,
          onPressed: onCancel,
          isEnabled: onCancel != null,
        ),
        const SizedBox(width: 12),
        _buildButton(
          context: context,
          text: 'Approve',
          backgroundColor: Colors.green.shade600,
          onPressed: onApprove,
          isEnabled: onApprove != null,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required Color backgroundColor,
    required VoidCallback? onPressed,
    required bool isEnabled,
    required BuildContext context,
  }) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? backgroundColor : Colors.grey.shade400,
        foregroundColor: Colors.white,
        fixedSize: const Size(140, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
