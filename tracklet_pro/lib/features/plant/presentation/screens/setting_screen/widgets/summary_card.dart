import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final bool dark;
  final Widget? trailing;
  const SummaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    this.dark = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final bg = dark ? const Color(0xff1f3f6a) : Colors.white;
    final fg = dark ? Colors.white : Colors.black87;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: dark ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: fg.withOpacity(0.9), fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: fg.withOpacity(0.7), fontSize: 12)),
                ],
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
