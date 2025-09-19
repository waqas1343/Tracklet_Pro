import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userInitials;
  final List<Widget>? actions;
  final bool showNotificationIcon;
  final bool showMessageIcon;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onMessagePressed;
  final VoidCallback? onProfilePressed;

  const CustomAppBar({
    super.key,
    this.userName = 'Waqas iLyas',
    this.userInitials = 'W',
    this.actions,
    this.showNotificationIcon = true,
    this.showMessageIcon = true,
    this.onNotificationPressed,
    this.onMessagePressed,
    this.onProfilePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AppBar(
      backgroundColor: AppColors.lightBlueBackground,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: onProfilePressed,
            child: CircleAvatar(
              radius: AppDimensions.iconDefault,
              backgroundColor: AppColors.darkBlue,
              child: Text(
                userInitials,
                style: textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingSmall),
          Text(userName, style: textTheme.titleLarge),
          const Spacer(),
          if (showMessageIcon) ...[
            _buildIconButton(
              icon: Icons.chat_bubble_outline,
              onPressed: onMessagePressed,
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
          ],

          if (showNotificationIcon) ...[
            _buildIconButton(
              icon: Icons.notifications_none,
              onPressed: onNotificationPressed,
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
          ],
          ...?actions,
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, VoidCallback? onPressed}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.darkGrey.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 24, color: AppColors.darkGrey),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
