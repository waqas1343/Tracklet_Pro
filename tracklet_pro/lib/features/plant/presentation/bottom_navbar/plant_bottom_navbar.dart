import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/presentation/bottom_navbar/provider/bottom_nav_provider.dart';
import 'package:tracklet_pro/features/order/presentation/screens/order_history_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/rates_screen/rates_screen.dart';
import '../screens/setting_screen/setting_screen.dart';

// Pre-cache SVG icons
final List<Widget> _screens = const [
  HomeScreen(),
  RatesScreen(),
  OrderHistoryScreen(),
  SettingScreen(),
];

class PlantBottomNavbar extends StatelessWidget {
  const PlantBottomNavbar({super.key});

  static const List<BottomNavItem> _navItems = [
    BottomNavItem(iconPath: 'assets/icons/home.svg', label: 'Home'),
    BottomNavItem(iconPath: 'assets/icons/employee.svg', label: 'Rates'),
    BottomNavItem(iconPath: 'assets/icons/order.svg', label: 'Orders'),
    BottomNavItem(iconPath: 'assets/icons/stock.svg', label: 'Stock'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, navProvider, _) {
        final currentIndex = navProvider.currentIndex;

        return Scaffold(
          body: _screens[currentIndex],
          bottomNavigationBar: _buildBottomNavBar(
            currentIndex,
            navProvider.changeIndex,
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar(int currentIndex, ValueChanged<int> onTap) {
    return BottomNavigationBar(
      backgroundColor: AppColors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.darkBlue,
      unselectedItemColor: AppColors.darkGrey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: List.generate(_navItems.length, (index) {
        final item = _navItems[index];
        final isSelected = currentIndex == index;

        return BottomNavigationBarItem(
          icon: _buildNavIcon(iconPath: item.iconPath, isSelected: isSelected),
          label: item.label,
        );
      }),
    );
  }

  Widget _buildNavIcon({required String iconPath, required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.darkBlue : AppColors.darkGrey,
          BlendMode.srcIn,
        ),
        width: 24,
        height: 24,
      ),
    );
  }
}
