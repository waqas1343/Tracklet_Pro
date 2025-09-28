import 'package:flutter/material.dart';

class FooterLinksRow extends StatelessWidget {
  final VoidCallback onLegal;
  final VoidCallback onPrivacy;
  const FooterLinksRow({super.key, required this.onLegal, required this.onPrivacy});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: onLegal,
          child: const Text('Legal Notice', style: TextStyle(color: Colors.black87)),
        ),
        TextButton(
          onPressed: onPrivacy,
          child: const Text('Privacy Policy', style: TextStyle(color: Colors.black87)),
        ),
      ],
    );
  }
}
