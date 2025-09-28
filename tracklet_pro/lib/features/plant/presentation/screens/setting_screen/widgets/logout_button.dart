import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff1f3f6a),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Icon(Icons.logout, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
