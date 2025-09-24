import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/widgets/attendance_list.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/widgets/attendance_tabs.dart';
import 'package:tracklet_pro/shared/widgets/custom_app_bar.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/add_employee_screen.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/widgets/attendance_search_field.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            AttendanceSearchField(),
            SizedBox(height: 12),
            AttendanceTabs(),
            SizedBox(height: 16),
            Expanded(child: AttendanceList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddEmployeeScreen()),
          );
        },
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Employee'),
      ),
    );
  }
}
