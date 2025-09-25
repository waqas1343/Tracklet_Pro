import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SummaryTab extends StatelessWidget {
  final String value;
  final String label;
  final String iconPath;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final String headerTop;
  final String headerBottom;

  const SummaryTab({
    super.key,
    required this.value,
    required this.label,
    required this.iconPath,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.headerTop,
    required this.headerBottom,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 100,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey.shade200,
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
                          color: isSelected ? Colors.white70 : Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        headerBottom,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
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
                      color: isSelected ? Colors.white24 : color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      iconPath,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        isSelected ? Colors.white : color,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
