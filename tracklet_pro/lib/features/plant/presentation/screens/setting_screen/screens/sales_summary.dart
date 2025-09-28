import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/presentation/widgets/download_report_dialog.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/provider/sales_summary_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/widgets/orders_overview_card.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/widgets/summary_card.dart';
import 'package:tracklet_pro/core/constants/dimens.dart';

class SalesSummaryScreen extends StatelessWidget {
  const SalesSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SalesSummaryProvider(context),
      child: const _SalesSummaryView(),
    );
  }
}

class _SalesSummaryView extends StatelessWidget {
  const _SalesSummaryView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SalesSummaryProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text('Sales & Reports', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.gap8),
              Text('Sales Summary', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: Dimens.gap12),

              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      title: 'Total',
                      subtitle: 'KG sold today',
                      value: '${provider.totalKgToday.toString()} KG',
                      dark: true,
                      trailing: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xff173357),
                        child: Icon(Icons.lock_outline, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      title: 'Today',
                      subtitle: 'Sales Amount',
                      value: '${_formatAmount(provider.totalAmountToday)} PKR',
                      trailing: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.savings_outlined, color: Colors.black, size: 16),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: Dimens.gap20),
              Text('Orders Overview', style: Theme.of(context).textTheme.headlineMedium),
              OrdersOverviewCard(
                title: 'Total Orders',
                period: provider.period,
                data: provider.weeklyOrders,
                highlightIndex: provider.selectedIndex,
                onPeriodChanged: provider.setPeriod,
              ),

              const SizedBox(height: Dimens.gap20),

              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View Detailed Report',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),

              const SizedBox(height: Dimens.gap12),

              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await showDownloadReportDialog(context);
                    if (result == null || !context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Export ${result.isDaily ? 'Daily' : 'Custom'} - ${result.date}')),
                    );
                  },
                  child: const Text('Download Report',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: Dimens.gap12),
            ],
          ),
        ),
      ),
    );
  }

  String _formatAmount(int amount) {
    // Basic formatting like 800,000
    final s = amount.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final idx = s.length - i;
      buf.write(s[i]);
      if (idx > 1 && idx % 3 == 1 && i != s.length - 1) buf.write(',');
    }
    return buf.toString();
  }
}
