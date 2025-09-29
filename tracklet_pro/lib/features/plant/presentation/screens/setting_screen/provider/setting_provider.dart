import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/screens/manag_plant.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/screens/sales_summary.dart';

/// Provider for Settings screen state
class SettingProvider extends ChangeNotifier {
  String userName = 'Bilal Ahmed';
  String get initials => _makeInitials(userName);

  bool isUrdu = false; // false = Eng, true = Urdu

  void toggleLanguage(bool value) {
    isUrdu = value;
    notifyListeners();
  }

  Future<void> onManagePlant(BuildContext context) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ManagePlantScreen()));
  }

  Future<void> onSalesSummary(BuildContext context) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SalesSummaryScreen()));
  }

  Future<void> onProfileSettings() async {}

  Future<void> onChangePassword() async {}

  Future<void> onDownloadReports(BuildContext context) async {}

  Future<void> onLegalNotice(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Legal Notice tapped')));
  }

  Future<void> onPrivacyPolicy(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Privacy Policy tapped')));
  }

  Future<void> logout(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Logged out')));
  }

  String _makeInitials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r"\s+"))
        .where((e) => e.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
