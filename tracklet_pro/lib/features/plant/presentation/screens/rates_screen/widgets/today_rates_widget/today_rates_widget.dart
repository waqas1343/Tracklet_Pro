import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/utils/validators/validators.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/rates_screen/provider/rate_provider/rate_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class TodayRateWidget extends StatelessWidget {
  const TodayRateWidget({super.key});

  void _showUpdateRateDialog(BuildContext context) {
    final provider = context.read<RateProvider>();
    final controller = TextEditingController(
      text: provider.todayRate.toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Rate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter new rate per KG:'),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixText: "PKR",
                  labelText: "Rate per KG",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                autofocus: true,
                validator: (value) => Validators.validatePositiveNumber(value, fieldName: 'Rate'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newRate = int.tryParse(controller.text);
                if (newRate != null && newRate > 0) {
                  provider.setTodayRate(newRate);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Rate updated to PKR $newRate successfully!",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid positive rate"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
              ),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RateProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today Rate per KG:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            Text(
              "PKR ${provider.todayRate.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: CustomButton(
                text: "Update Rate",
                onPressed: () => _showUpdateRateDialog(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
