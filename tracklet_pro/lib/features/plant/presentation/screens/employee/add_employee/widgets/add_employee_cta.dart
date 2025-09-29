import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/employee_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';
import 'package:tracklet_pro/core/utils/snackbar_util/custom_flushbar.dart';
import 'package:tracklet_pro/core/utils/validators/validators.dart';

// SECTION: Bottom CTA button that opens the Add Employee dialog (UI unchanged)
class AddEmployeeCTA extends StatelessWidget {
  const AddEmployeeCTA({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: CustomButton(
        text: 'Add Employee',
        onPressed: () => _showAddDialog(context),
      ),
    );
  }

  // SECTION: Dialog for adding a new employee
  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final designationController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Employee'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValidationBuilder.nameTextField(
              controller: nameController,
              hintText: 'Enter employee name',
            ),
            const SizedBox(height: 16),
            ValidationBuilder.requiredTextField(
              controller: designationController,
              hintText: 'Enter designation (e.g., Supervisor)',
              validator: Validators.validateDesignation,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final designation = designationController.text.trim();

              if (name.isNotEmpty && designation.isNotEmpty) {
                Provider.of<EmployeeProvider>(context, listen: false)
                    .addEmployee(name, designation);

                Navigator.pop(dialogContext);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    CustomFlushbar.showSuccess(
                      context,
                      message: 'Employee added successfully',
                    );
                  }
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    CustomFlushbar.showError(
                      context,
                      message: 'Please fill all required fields',
                    );
                  }
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
