import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Key for the animation to prevent unnecessary rebuilds
final _animationKey = const ValueKey('summary_tab_animation');

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
        key: _animationKey,
        height: 100,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Spacer(),
            _buildValue(),
            const SizedBox(height: 4),
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
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              headerTop,
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              headerBottom,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                height: 1.2,
              ),
            ),
          ],
        ),
        _buildIcon(),
      ],
    );
  }

  Widget _buildIcon() {
    return Container(
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
        cacheColorFilter: true,
      ),
    );
  }

  Widget _buildValue() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          height: 1.2,
        ),
      ),
    );
  }
}
