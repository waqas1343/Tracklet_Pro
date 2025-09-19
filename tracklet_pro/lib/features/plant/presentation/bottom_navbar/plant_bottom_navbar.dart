import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/domain/providers/bottom_nav_provider.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/request_screen/request_screen.dart';
import '../screens/scan_screen/scan_screen.dart';
import '../screens/orders_screen/orders_screen.dart';
import '../screens/stock_screen/stock_screen.dart';

class PlantBottomNavbar extends StatelessWidget {
  const PlantBottomNavbar({super.key});

  static const List<BottomNavItem> _navItems = [
    BottomNavItem(iconPath: 'assets/icons/home.svg', label: 'Home'),
    BottomNavItem(iconPath: 'assets/icons/request.svg', label: 'Request'),
    BottomNavItem(iconPath: 'assets/icons/scan.svg', label: 'Scan'),
    BottomNavItem(iconPath: 'assets/icons/order.svg', label: 'Orders'),
    BottomNavItem(iconPath: 'assets/icons/stock.svg', label: 'Stock'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, navProvider, _) {
        return Scaffold(
          body: IndexedStack(
            index: navProvider.currentIndex,
            children: const [
              HomeScreen(),
              RequestScreen(),
              ScanScreen(),
              OrdersScreen(),
              StockScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.white,
            currentIndex: navProvider.currentIndex,
            onTap: navProvider.changeIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.darkBlue,
            unselectedItemColor: AppColors.darkGrey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            items: _navItems.map((item) {
              return BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset(
                    item.iconPath,
                    colorFilter: ColorFilter.mode(
                      navProvider.currentIndex == _navItems.indexOf(item)
                          ? AppColors.darkBlue
                          : AppColors.darkGrey,
                      BlendMode.srcIn,
                    ),
                    width: 24,
                    height: 24,
                  ),
                ),
                label: item.label,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
