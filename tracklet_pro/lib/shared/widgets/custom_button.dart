import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);

    // Always use provided background color if available, otherwise use theme
    final buttonBgColor = backgroundColor ??
        (isOutlined
            ? Colors.transparent
            : isDark
                ? theme.colorScheme.onPrimary
                : theme.primaryColor);

    final buttonTextColor = textColor ?? (isDark ? theme.colorScheme.onSurface : theme.colorScheme.onPrimary);

    // For disabled state, use theme disabled colors
    final disabledBgColor = isOutlined
        ? Colors.transparent
        : theme.disabledColor;

    final disabledTextColor = isOutlined
        ? theme.disabledColor
        : theme.colorScheme.onSurface.withValues(alpha: 0.38);

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
      textStyle: theme.textTheme.labelLarge?.copyWith(
        color: isEnabled ? buttonTextColor : disabledTextColor,
      ) ?? TextStyle(
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
        child: _buildButtonContent(buttonTextColor, disabledTextColor, theme),
      ),
    );
  }

  Widget _buildButtonContent(Color textColor, Color disabledTextColor, ThemeData theme) {
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
          style: theme.textTheme.labelLarge?.copyWith(
            color: color,
          ) ?? TextStyle(
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
