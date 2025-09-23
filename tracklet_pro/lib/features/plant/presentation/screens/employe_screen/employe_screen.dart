import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/widgets/attendance_header.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/widgets/attendance_list.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/widgets/employe_summary.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: const Text("BA", style: TextStyle(color: Colors.white)),
        ),
        title: const Text(
          "Bilal Ahmed",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Icon(Icons.chat_bubble_outline, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EmployeeSummary(),
            const SizedBox(height: 20),
            const AttendanceHeader(),
            const SizedBox(height: 10),
            Expanded(child: AttendanceList()),
          ],
        ),
      ),
    );
  }
}
