import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/presentation/widgets/download_report_dialog.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Orders History",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffccd3dd),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          onPressed: () async {
            final result = await showDownloadReportDialog(context);
            if (result != null) {
              // TODO: Replace with real export action (PDF/CSV)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Export: ${result.isDaily ? 'Daily' : 'Custom'} - ${result.date.day.toString().padLeft(2, '0')}-${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][result.date.month - 1]}-${(result.date.year % 100).toString().padLeft(2, '0')}',
                  ),
                ),
              );
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Download Report",
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/icons/cloudDownload.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.darkBlue,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
