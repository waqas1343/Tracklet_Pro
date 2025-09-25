import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/assets/app_icons.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';

class AttendanceTabs extends StatelessWidget {
  const AttendanceTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);
    final total = provider.totalEmployees;
    final present = provider.presentCount;
    final absent = provider.absentCount;
    final late = provider.lateCount;

    Widget buildTab({
      required String label,
      required bool selected,
      required VoidCallback onTap,
      required String iconPath,
      required String headerTop,
      required String headerBottom,
      required Color color,
    }) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            height: 100,
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: selected ? AppColors.mediumBlue : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headerTop,
                            style: TextStyle(
                              color: selected ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7) : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            headerBottom,
                            style: TextStyle(
                              color: selected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: selected
                              ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2)
                              : color.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          iconPath,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            selected ? Theme.of(context).colorScheme.onPrimary : color,
                            BlendMode.srcIn,
                          ),

                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(strokeWidth: 1.5),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: selected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        buildTab(
          label: '$total',
          selected: provider.selectedTab == AttendanceTab.total,
          onTap: () => provider.setSelectedTab(AttendanceTab.total),
          iconPath: AppIcons.totalEmployees,
          color: AppColors.mediumBlue,
          headerTop: 'Total',
          headerBottom: 'Employees',
        ),
        const SizedBox(width: 8),
        buildTab(
          label: '$present',
          selected: provider.selectedTab == AttendanceTab.present,
          onTap: () => provider.setSelectedTab(AttendanceTab.present),
          iconPath: AppIcons.present,
          color: AppColors.mediumBlue,
          headerTop: 'Present',
          headerBottom: 'Employees',
        ),
        const SizedBox(width: 8),
        buildTab(
          label: late > 0 ? '$absent, $late' : '$absent',
          selected: provider.selectedTab == AttendanceTab.absent,
          onTap: () => provider.setSelectedTab(AttendanceTab.absent),
          iconPath: AppIcons.absent,
          color: Colors.red,
          headerTop: 'Absent',
          headerBottom: 'Employees',
        ),
      ],
    );
  }
}
