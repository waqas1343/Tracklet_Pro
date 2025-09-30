import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';

class DistributorDriverCard extends StatelessWidget {
  final String name;
  final String status;
  final String description;
  final bool showAvatar;
  final VoidCallback? onTap;
  const DistributorDriverCard({
    super.key,
    required this.name,
    required this.status,
    required this.description,
    this.showAvatar = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = status == "Available";

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.disabledColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: showAvatar
            ? const CircleAvatar()
            : CircleAvatar(
                backgroundColor: isAvailable
                    ? Colors.green.shade100
                    : Colors.orange.shade100,
                child: Text(
                  name.split(" ").map((e) => e[0]).join("").toUpperCase(),
                  style: TextStyle(
                    color: isAvailable
                        ? Colors.green.shade800
                        : Colors.orange.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isAvailable ? Colors.green : Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
