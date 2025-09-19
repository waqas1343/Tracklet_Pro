import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final bool isEnabled;
  final Widget? icon;
  final MainAxisAlignment? alignment;
  final double? elevation;
  final bool isOutlined;
  static const EdgeInsets defaultPadding = EdgeInsets.symmetric(
    vertical: 14,
    horizontal: 24,
  );
  static const double defaultBorderRadius = 12.0;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.isEnabled = true,
    this.icon,
    this.alignment,
    this.elevation,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final buttonBgColor = isOutlined
        ? Colors.transparent
        : isDark
        ? Colors.white
        : AppColors.darkBlue;

    final buttonTextColor = isDark ? Colors.black : Colors.white;

    final disabledBgColor = isOutlined
        ? Colors.transparent
        : isDark
        ? Colors.grey[300]!
        : AppColors.darkBlue;

    final disabledTextColor = isOutlined
        ? isDark
              ? Colors.grey[400]!
              : AppColors.darkBlue
        : isDark
        ? Colors.black54
        : Colors.white70;

    final buttonStyle = isOutlined
        ? OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: buttonTextColor,
            disabledForegroundColor: disabledTextColor,
            side: BorderSide(
              color: isEnabled ? AppColors.darkBlue : AppColors.darkBlue,
              width: 1.5,
            ),
            elevation: 0,
            padding: defaultPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
              color: AppColors.black,
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: buttonBgColor,
            disabledBackgroundColor: disabledBgColor,
            foregroundColor: buttonTextColor,
            disabledForegroundColor: disabledTextColor,
            elevation: 2.0,
            shadowColor: AppColors.black,
            padding: defaultPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
              color: AppColors.black,
            ),
          );

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.0,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isEnabled ? onPressed : null,
              style: buttonStyle as ButtonStyle?,
              child: _buildButtonContent(buttonTextColor, disabledTextColor),
            )
          : ElevatedButton(
              onPressed: isEnabled ? onPressed : null,
              style: buttonStyle,
              child: _buildButtonContent(buttonTextColor, disabledTextColor),
            ),
    );
  }

  Widget _buildButtonContent(Color textColor, Color disabledTextColor) {
    final color = isEnabled ? textColor : disabledTextColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment ?? MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(color: color, size: 20.0),
            child: icon!,
          ),
          const SizedBox(width: 8.0),
        ],
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}
