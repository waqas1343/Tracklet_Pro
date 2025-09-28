import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/home_screen/provider/new_order_form_provider.dart';

class NewOrderFormSheet extends StatelessWidget {
  const NewOrderFormSheet({super.key});

  static Future<OrderModel?> show(BuildContext context) {
    return showModalBottomSheet<OrderModel>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => ChangeNotifierProvider(
        create: (_) => NewOrderFormProvider(),
        child: const _FormBody(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _FormBody extends StatelessWidget {
  const _FormBody();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final p = context.watch<NewOrderFormProvider>();
    final insets = MediaQuery.of(context).viewInsets.bottom;
    final firstFocus = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!firstFocus.hasFocus) {
        firstFocus.requestFocus();
      }
    });

    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: insets + 16, top: 16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create New Order', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),

            // Name
            TextFormField(
              controller: p.nameController,
              autofocus: true,
              focusNode: firstFocus,
              decoration: const InputDecoration(labelText: 'Trader Name'),
              textInputAction: TextInputAction.next,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 8),

            // Location
            TextFormField(
              controller: p.locationController,
              decoration: const InputDecoration(labelText: 'Location (optional)'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),

            // Special Instruction
            TextFormField(
              controller: p.instructionController,
              decoration: const InputDecoration(labelText: 'Special Instruction (optional)'),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 16),

            Text('Quantities', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: p.qty50Controller,
                    decoration: const InputDecoration(labelText: '50 KG (qty)'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: p.qty100Controller,
                    decoration: const InputDecoration(labelText: '100 KG (qty)'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: p.qty20Controller,
                    decoration: const InputDecoration(labelText: '20 KG (qty)'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total KG:', style: Theme.of(context).textTheme.bodyMedium),
                Text('${p.totalKg}', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    final err = p.validate();
                    if (formKey.currentState!.validate() && err == null) {
                      Navigator.of(context).pop(p.buildOrderModel());
                    } else {
                      if (err != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
                      }
                    }
                  },
                  child: const Text('Add Order'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
