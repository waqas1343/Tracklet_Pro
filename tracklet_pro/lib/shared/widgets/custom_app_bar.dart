import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: theme.colorScheme.surface,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: onProfilePressed,
            child: CircleAvatar(
              radius: AppDimensions.iconDefault,
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                userInitials,
                style: textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingSmall),
          Text(userName, style: textTheme.titleLarge),
          const Spacer(),
          if (showMessageIcon) ...[
            _buildIconButton(
              context: context,
              iconPath: 'assets/icons/chat.svg',
              onPressed: onMessagePressed,
            ),
            const SizedBox(width: AppDimensions.borderRadiusSmall),
          ],

          if (showNotificationIcon) ...[
            _buildIconButton(
              context: context,
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

  Widget _buildIconButton({required BuildContext context, required String iconPath, VoidCallback? onPressed}) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusDefault),
        border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          iconPath,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            Theme.of(context).iconTheme.color ?? Colors.grey,
            BlendMode.srcIn,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
