import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../assets/app_assets.dart';

class AppIcons {
  static const home = AppAssets.homeIcon;
  static const profile = AppAssets.profileIcon;
  static const settings = AppAssets.settingsIcon;
  static const notification = AppAssets.notificationIcon;
  static const search = AppAssets.searchIcon;
  static const email = AppAssets.emailIcon;
  static const password = AppAssets.lockIcon;
  static const user = AppAssets.userIcon;
  static const visibilityOn = AppAssets.visibilityOnIcon;
  static const visibilityOff = AppAssets.visibilityOffIcon;

  static Widget show(String icon, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      icon,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  static Widget btn(
    String icon,
    VoidCallback onTap, {
    double size = 24,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: show(icon, size: size, color: color),
    );
  }
}
