import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    }) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            height: 100,
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: selected ? AppColors.darkBlue : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headerTop,
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white70
                                      : Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),

                              Text(
                                headerBottom,
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.softBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          iconPath,
                          width: 14,
                          height: 14,
                          colorFilter: ColorFilter.mode(
                            selected ? Colors.white : Colors.black87,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
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
          headerTop: 'Total',
          headerBottom: 'Employees',
        ),
        const SizedBox(width: 10),
        buildTab(
          label: '$present',
          selected: provider.selectedTab == AttendanceTab.present,
          onTap: () => provider.setSelectedTab(AttendanceTab.present),
          iconPath: AppIcons.present,
          headerTop: 'Present',
          headerBottom: 'Employees',
        ),
        const SizedBox(width: 10),
        buildTab(
          label: late > 0 ? '$absent, Late $late' : '$absent',
          selected: provider.selectedTab == AttendanceTab.absent,
          onTap: () => provider.setSelectedTab(AttendanceTab.absent),
          iconPath: AppIcons.absent,
          headerTop: 'Absent',
          headerBottom: 'Employees',
        ),
      ],
    );
  }
}
