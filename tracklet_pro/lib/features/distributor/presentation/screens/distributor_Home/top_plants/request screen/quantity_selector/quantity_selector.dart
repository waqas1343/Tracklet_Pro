import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/distributor/presentation/screens/distributor_Home/top_plants/request%20screen/provider/distributor_request_provider.dart';

class QuantitySelector extends StatelessWidget {
  final double weight;

  const QuantitySelector({super.key, required this.weight});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DistributorRequestProvider>(context);
    final qty = provider.quantities[weight] ?? 0;
    final String buttonId = 'minus_${weight}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$weight", style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            GestureDetector(
              onTapDown: (_) => provider.setPressedButton(buttonId),
              onTapUp: (_) => provider.clearPressedButton(),
              onTapCancel: () => provider.clearPressedButton(),
              onTap: () => provider.decreaseQty(weight),
              child: Icon(
                Icons.remove_circle_outline,
                color: provider.isButtonPressed(buttonId)
                    ? AppColors.darkBlue
                    : AppColors.disabledColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              qty.toString().padLeft(2, '0'),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTapDown: (_) => provider.setPressedButton('plus_${weight}'),
              onTapUp: (_) => provider.clearPressedButton(),
              onTapCancel: () => provider.clearPressedButton(),
              onTap: () => provider.increaseQty(weight),
              child: Icon(
                Icons.add_circle_outline,
                color: provider.isButtonPressed('plus_${weight}')
                    ? AppColors.darkBlue
                    : Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
