import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: AppColors.white,
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
              iconPath: 'assets/icons/chat.svg',
              onPressed: onMessagePressed,
            ),
            const SizedBox(width: AppDimensions.borderRadiusSmall),
          ],

          if (showNotificationIcon) ...[
            _buildIconButton(
              iconPath: 'assets/icons/notification.svg',
              onPressed: onNotificationPressed,
            ),
            const SizedBox(width: AppDimensions.borderRadiusSmall),
          ],
          ...?actions,
        ],
      ),
    );
  }

  Widget _buildIconButton({required String iconPath, VoidCallback? onPressed}) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.darkGrey, width: 0.5),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          iconPath,
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(AppColors.darkGrey, BlendMode.srcIn),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
