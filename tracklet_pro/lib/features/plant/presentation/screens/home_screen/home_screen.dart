import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/plant_summary/plant_summary_row.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/order_cards/new_order_card.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/order_cards/previous_order_card.dart';
import 'package:tracklet_pro/features/plant/presentation/widgets/section_header/section_header_widget.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/provider/home_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/widgets/new_order_form_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.watch<HomeProvider>();
      return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppDimensions.paddingDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SectionHeaderWidget(title: "Plant Summary", onSeeAll: () {}),
                const SizedBox(height: AppDimensions.spaceDefault),
                const PlantSummaryRow(),
                const SizedBox(height: AppDimensions.paddingDefault * 1.5),
                SectionHeaderWidget(title: "New Orders", onSeeAll: () {}),
                const SizedBox(height: 8),
                // Pending orders created from FAB
                for (final o in context.watch<HomeProvider>().pendingOrders) ...[
                  NewOrderCard(
                    traderName: o.traderName,
                    traderTitle: 'Requested cylinders',
                    driverName: o.driverName ?? '-',
                    specialInstructor: o.specialInstruction ?? '-',
                    items: o.requestedItems,
                    totalKg: '${o.totalKg} KG',
                    onApprove: () async {
                      final rate = await _askRatePerKg(context);
                      if (!context.mounted) return;
                      if (rate == null) return;
                      await context.read<HomeProvider>().approveOrder(context: context, order: o, ratePerKg: rate);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order approved and moved to Completed')),
                      );
                    },
                    onCancel: () async {
                      await context.read<HomeProvider>().cancelOrder(context: context, order: o);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Order cancelled and moved to Cancelled')),
                      );
                    },
                  ),
                  const SizedBox(height: AppDimensions.paddingDefault),
                ],
                NewOrderCard(
                  traderName: "Arham Traders",
                  traderTitle:
                      "Arham Traders placed a request for\nmentioned cylinders",
                  driverName: "Romail Ahmed",
                  specialInstructor: "John Doe",
                  items: const ["50 KG (3)", "15 KG (5)"],
                  totalKg: "150 KG",
                  onApprove: () async {
                    final rate = await _askRatePerKg(context);
                    if (!context.mounted) return;
                    if (rate == null) return;
                    final model = _buildOrderModel(
                      trader: "Arham Traders",
                      items: const ["50 KG (3)", "15 KG (5)"],
                      totalKgText: "150 KG",
                      status: 'New',
                    );
                    await context.read<HomeProvider>().approveOrder(
                      context: context,
                      order: model,
                      ratePerKg: rate,
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order approved and moved to Completed')),
                    );
                  },
                  onCancel: () async {
                    final model = _buildOrderModel(
                      trader: "Arham Traders",
                      items: const ["50 KG (3)", "15 KG (5)"],
                      totalKgText: "150 KG",
                      status: 'New',
                    );
                    await context.read<HomeProvider>().cancelOrder(
                      context: context,
                      order: model,
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order cancelled and moved to Cancelled')),
                    );
                  },
                ),
                const SizedBox(height: AppDimensions.paddingDefault * 1.5),
                SectionHeaderWidget(title: "Previous Orders", onSeeAll: () {}),
                const SizedBox(height: 12),
                const PreviousOrderCard(
                  traderName: "Arham Traders",
                  driverName: "Romail Ahmed",
                  items: ["50 KG (3)", "15 KG (5)"],
                  status: "Completed",
                  statusColor: AppColors.successColor,
                ),
                const SizedBox(height: 12),
                const PreviousOrderCard(
                  traderName: "Arham Traders",
                  driverName: "Romail Ahmed",
                  items: ["50 KG (3)", "15 KG (5)"],
                  status: "Cancelled",
                  statusColor: AppColors.errorColor,
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final created = await NewOrderFormSheet.show(context);
            if (created != null && context.mounted) {
              context.read<HomeProvider>().addNewOrder(created);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New order added to queue')),
              );
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('New Order'),
        ),
      );
    });
  }
}

Future<double?> _askRatePerKg(BuildContext context) async {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return showDialog<double>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Enter Rate per KG'),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(hintText: 'e.g. 250'),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Required';
            final parsed = double.tryParse(v);
            if (parsed == null || parsed <= 0) return 'Enter valid rate';
            return null;
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.of(ctx).pop(double.parse(controller.text));
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

_buildOrderModel({
  required String trader,
  required List<String> items,
  required String totalKgText,
  required String status,
}) {
  // totalKgText format: "150 KG"
  final kg = int.tryParse(totalKgText.split(' ').first) ?? 0;
  return OrderModel(
    traderName: trader,
    requestedItems: items,
    totalKg: kg,
    totalBill: 0,
    status: status,
    createdAt: DateTime.now(),
  );
}
