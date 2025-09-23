import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'attendance_tile.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({super.key});

  @override
  Widget build(BuildContext context) {
    final employees = Provider.of<EmployeeProvider>(context).employees;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey.shade200,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Employee ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return AttendanceTile(employee: employees[index]);
            },
          ),
        ),
      ],
    );
  }
}
