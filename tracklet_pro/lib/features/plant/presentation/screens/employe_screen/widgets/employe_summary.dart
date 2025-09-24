import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class EmployeeSummary extends StatelessWidget {
  const EmployeeSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Employee Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomButton(text: "Add Employee", onPressed: () {}),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCard(
              context,
              'total',
              "Total Employees",
              provider.totalEmployees.toString(),
              "assets/icons/employee.svg",
              Colors.blue,
            ),
            _buildCard(
              context,
              'present',
              "Present Today",
              provider.presentCount.toString(),
              "assets/icons/user.svg",
              Colors.green,
            ),
            _buildCard(
              context,
              'absent',
              "Absent Today",
              provider.absentCount.toString(),
              "assets/icons/profile.svg",
              Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    String cardKey,
    String title,
    String value,
    String iconPath,
    Color color,
  ) {
    final empProvider = Provider.of<EmployeeProvider>(context);
    final bool isPressed = empProvider.pressedSummaryKey == cardKey;

    return GestureDetector(
      onTapDown: (_) => empProvider.setPressedSummaryKey(cardKey),
      onTapUp: (_) => empProvider.setPressedSummaryKey(null),
      onTapCancel: () => empProvider.setPressedSummaryKey(null),
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPressed ? Colors.blue[900] : Colors.grey.shade100,
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isPressed ? Colors.white : color,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isPressed ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isPressed ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
