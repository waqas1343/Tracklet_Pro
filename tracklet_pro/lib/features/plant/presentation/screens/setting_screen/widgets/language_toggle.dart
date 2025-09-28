import 'package:flutter/material.dart';

class LanguageToggle extends StatelessWidget {
  final bool isUrdu;
  final ValueChanged<bool> onChanged;
  const LanguageToggle({super.key, required this.isUrdu, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Eng'),
        const SizedBox(width: 8),
        Switch(
          value: isUrdu,
          onChanged: onChanged,
        ),
        const SizedBox(width: 8),
        const Text('Urdu'),
      ],
    );
  }
}
