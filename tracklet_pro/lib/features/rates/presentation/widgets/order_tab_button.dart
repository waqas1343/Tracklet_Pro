import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';

class OrderTabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const OrderTabButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // Fixed height
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 155,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xff1f3f6a) : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: isActive ? Color(0xffccd3dd) : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/gassMeter.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      isActive ? AppColors.white : Colors.black87,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
