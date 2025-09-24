import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/model/employe_model.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';

class AttendanceTile extends StatelessWidget {
  final EmployeeModel employee;
  final bool showActions;
  const AttendanceTile({
    super.key,
    required this.employee,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);
    final onTotalTab = provider.selectedTab == AttendanceTab.total;
    final onAbsentTab = provider.selectedTab == AttendanceTab.absent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(employee.id, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(employee.name, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: onTotalTab
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ChoiceChip(
                            label: const Text("Absent"),
                            selected: !employee.isPresent,
                            showCheckmark: false,
                            onSelected: (_) {
                              Provider.of<EmployeeProvider>(
                                context,
                                listen: false,
                              ).toggleAttendance(employee.id, false);
                            },
                            selectedColor: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          ChoiceChip(
                            label: const Text("Present"),
                            selected: employee.isPresent,
                            showCheckmark: false,
                            onSelected: (_) {
                              Provider.of<EmployeeProvider>(
                                context,
                                listen: false,
                              ).toggleAttendance(employee.id, true);
                            },
                            selectedColor: Colors.green,
                          ),
                        ],
                      )
                    : (onAbsentTab
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: employee.status == 'late'
                                        ? Colors.orange
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    employee.status == 'late'
                                        ? 'Late - ${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(employee.lateTime ?? DateTime.now()))}'
                                        : 'Absent',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (employee.status != 'late') ...[
                                  const SizedBox(width: 8),
                                  OutlinedButton(
                                    onPressed: () {
                                      Provider.of<EmployeeProvider>(
                                        context,
                                        listen: false,
                                      ).markLate(employee.id, DateTime.now());
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.orange,
                                      ),
                                      foregroundColor: Colors.orange.shade800,
                                    ),
                                    child: const Text('Mark Late'),
                                  ),
                                ],
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: employee.isPresent
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                employee.isPresent ? 'Present' : 'Absent',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
              ),
            ),
          ),
          if (showActions) ...[
            const SizedBox(width: 8),
            SizedBox(
              width: 40,
              child: IconButton(
                tooltip: 'Edit',
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () async {
                  final controller = TextEditingController(text: employee.name);
                  final newName = await showDialog<String>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Rename Employee'),
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter new name',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            final v = controller.text.trim();
                            if (v.isNotEmpty) Navigator.pop(ctx, v);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                  if (newName != null && newName.trim().isNotEmpty) {
                    Provider.of<EmployeeProvider>(
                      context,
                      listen: false,
                    ).renameEmployee(employee.id, newName.trim());
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 40,
              child: IconButton(
                tooltip: 'Delete',
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
                onPressed: () {
                  Provider.of<EmployeeProvider>(
                    context,
                    listen: false,
                  ).deleteEmployee(employee.id);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
