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
    final provider = context.watch<EmployeeProvider>();
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
                    ? _buildTotalTab(context, provider)
                    : (onAbsentTab
                          ? _buildAbsentTab(context, provider)
                          : _buildStatusChip(employee)),
              ),
            ),
          ),
          if (showActions) ..._buildActionButtons(context, provider),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildTotalTab(BuildContext context, EmployeeProvider provider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ChoiceChip(
          label: const Text("Absent"),
          selected: employee.isPresent == false,
          showCheckmark: false,
          onSelected: (_) => provider.toggleAttendance(employee.id, false),
          selectedColor: Colors.red,
          backgroundColor: employee.isPresent == null ? Colors.grey[200] : null,
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text("Present"),
          selected: employee.isPresent == true,
          showCheckmark: false,
          onSelected: (_) => provider.toggleAttendance(employee.id, true),
          selectedColor: Colors.green,
          backgroundColor: employee.isPresent == null ? Colors.grey[200] : null,
        ),
      ],
    );
  }

  Widget _buildAbsentTab(BuildContext context, EmployeeProvider provider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: employee.status == 'late' ? Colors.orange : Colors.red,
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
            onPressed: () => provider.markLate(employee.id, DateTime.now()),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.orange),
              foregroundColor: Colors.orange.shade800,
            ),
            child: const Text('Mark Late'),
          ),
        ],
      ],
    );
  }

  Widget _buildStatusChip(EmployeeModel employee) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: employee.isPresent == true
            ? Colors.green
            : employee.isPresent == false
            ? Colors.red
            : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        employee.isPresent == true
            ? 'Present'
            : employee.isPresent == false
            ? 'Absent'
            : 'Not Marked',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons(
    BuildContext context,
    EmployeeProvider provider,
  ) {
    return [
      const SizedBox(width: 8),
      SizedBox(
        width: 40,
        child: IconButton(
          tooltip: 'Edit',
          icon: const Icon(Icons.edit_outlined, size: 20),
          onPressed: () => _showEditDialog(context, provider),
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
          onPressed: () => provider.deleteEmployee(employee.id),
        ),
      ),
    ];
  }

  Future<void> _showEditDialog(
    BuildContext context,
    EmployeeProvider provider,
  ) async {
    final controller = TextEditingController(text: employee.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename Employee'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter new name'),
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
      provider.renameEmployee(employee.id, newName.trim());
    }
  }
}
