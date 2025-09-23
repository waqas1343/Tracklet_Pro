import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? errorText;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
    this.onSubmitted,
    this.autofocus = false,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      focusNode: focusNode,
      textCapitalization: textCapitalization,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: isDark ? AppColors.white : AppColors.black,
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? AppColors.mediumBlue : AppColors.white,
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: isDark ? AppColors.white : AppColors.darkGrey,
        ),
        labelText: labelText,
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          color: isDark ? AppColors.white : AppColors.darkGrey,
        ),
        errorText: errorText,
        errorStyle: theme.textTheme.bodySmall?.copyWith(
          color: Colors.redAccent,
        ),
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: isDark ? AppColors.white : AppColors.darkGrey,
                ),
                child: prefixIcon!,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: isDark ? AppColors.white : AppColors.darkGrey,
                ),
                child: suffixIcon!,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkGrey, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkGrey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.black, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.softBlue, width: 1.5),
        ),
      ),
    );
  }
}
