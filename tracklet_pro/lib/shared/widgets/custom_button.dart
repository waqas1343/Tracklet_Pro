import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final bool isEnabled;
  final Widget? icon;
  final MainAxisAlignment? alignment;
  final double? elevation;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
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
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Always use provided background color if available, otherwise use theme
    final buttonBgColor = backgroundColor ?? 
        (isOutlined
            ? Colors.transparent
            : isDark
                ? Colors.white
                : AppColors.darkBlue);

    final buttonTextColor = textColor ?? (isDark ? Colors.black : Colors.white);

    // For disabled state, use a lighter version of the background color
    final disabledBgColor = isOutlined
        ? Colors.transparent
        : isDark
        ? Colors.grey[300]!
        : Colors.grey[300]!;

    final disabledTextColor = isOutlined
        ? isDark
              ? Colors.grey[400]!
              : AppColors.darkBlue
        : isDark
        ? Colors.black54
        : Colors.white70;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isEnabled ? buttonBgColor : disabledBgColor,
      foregroundColor: isEnabled ? buttonTextColor : disabledTextColor,
      elevation: elevation ?? 0,
      padding: defaultPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? defaultBorderRadius),
        side: isOutlined
            ? BorderSide(
                color: isEnabled
                    ? (textColor ?? buttonTextColor)
                    : disabledTextColor,
                width: 1.5,
              )
            : BorderSide.none,
      ),
      textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.1,
        color: isEnabled ? buttonTextColor : disabledTextColor,
      ),
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.0,
      child: ElevatedButton(
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
