import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/presentation/widgets/download_report_dialog.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/provider/setting_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/widgets/settings_header.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/widgets/setting_tile.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/widgets/language_toggle.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/widgets/footer_links_row.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/widgets/logout_button.dart';
import 'package:tracklet_pro/core/constants/dimens.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingProvider(),
      child: const _SettingView(),
    );
  }
}

class _SettingView extends StatelessWidget {
  const _SettingView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SettingProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header (avatar, name, actions)
              SettingsHeader(
                userName: provider.userName,
                initials: provider.initials,
                onInboxTap: () {},
                onNotificationsTap: () {},
              ),
              const SizedBox(height: Dimens.gap16),

              // Title
              Text('Setting', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: Dimens.gap12),

              // Setting tiles
              SettingTile(title: 'Manage Plant', onTap: () => provider.onManagePlant(context)),
              const SizedBox(height: Dimens.gap10),
              SettingTile(title: 'Sales Summary', onTap: () => provider.onSalesSummary(context)),
              const SizedBox(height: Dimens.gap10),
              SettingTile(title: 'Profile Settings', onTap: provider.onProfileSettings),
              const SizedBox(height: Dimens.gap10),
              SettingTile(title: 'Change Password', onTap: provider.onChangePassword),
              const SizedBox(height: Dimens.gap10),
              SettingTile(
                title: 'Download Reports',
                onTap: () async {
                  final result = await showDownloadReportDialog(context);
                  if (result != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Export: ${result.isDaily ? 'Daily' : 'Custom'} - ${result.date.day.toString().padLeft(2, '0')}-${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][result.date.month - 1]}-${(result.date.year % 100).toString().padLeft(2, '0')}',
                        ),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: Dimens.gap20),
              Text('Language', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Dimens.gap8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  LanguageToggle(
                    isUrdu: provider.isUrdu,
                    onChanged: provider.toggleLanguage,
                  ),
                ],
              ),

              const SizedBox(height: Dimens.gap8),
              FooterLinksRow(
                onLegal: () => provider.onLegalNotice(context),
                onPrivacy: () => provider.onPrivacyPolicy(context),
              ),

              const SizedBox(height: Dimens.gap12),
              LogoutButton(onTap: () => provider.logout(context)),
            ],
          ),
        ),
      ),
    );
  }
}