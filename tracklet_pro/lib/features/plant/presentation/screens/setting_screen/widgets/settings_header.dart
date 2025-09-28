import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final String userName;
  final String initials;
  final VoidCallback onInboxTap;
  final VoidCallback onNotificationsTap;
  const SettingsHeader({
    super.key,
    required this.userName,
    required this.initials,
    required this.onInboxTap,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xff1f3f6a),
          child: Text(
            initials,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            userName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: onInboxTap,
          icon: const Icon(Icons.chat_bubble_outline),
          color: Colors.black87,
        ),
        IconButton(
          onPressed: onNotificationsTap,
          icon: const Icon(Icons.notifications_none_rounded),
          color: Colors.black87,
        ),
      ],
    );
  }
}
