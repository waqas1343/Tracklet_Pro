import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String status;
  final bool isLate;
  final DateTime? lateTime;

  const StatusChip({
    super.key,
    required this.status,
    this.isLate = false,
    this.lateTime,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    String text;

    if (isLate && lateTime != null) {
      bgColor = Colors.orange;
      text =
          'Late - ${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(lateTime!))}';
    } else if (status == 'present') {
      bgColor = Colors.green;
      text = 'Present';
    } else {
      bgColor = Colors.red;
      text = 'Absent';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
