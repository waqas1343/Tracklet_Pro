import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/model/employe_model.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';

class AttendanceTile extends StatelessWidget {
  final EmployeeModel employee;
  const AttendanceTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          Flexible(flex: 2, child: Text(employee.id, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),
          Flexible(flex: 3, child: Text(employee.name, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 8),
          Flexible(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChoiceChip(
                      label: const Text("Absent"),
                      selected: !employee.isPresent,
                      showCheckmark: false,
                      onSelected: (_) {
                        Provider.of<EmployeeProvider>(context, listen: false)
                            .toggleAttendance(employee.id, false);
                      },
                      selectedColor: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text("Present"),
                      selected: employee.isPresent,
                      showCheckmark: false,
                      onSelected: (_) {
                        Provider.of<EmployeeProvider>(context, listen: false)
                            .toggleAttendance(employee.id, true);
                      },
                      selectedColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
