import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/utils/snackbar_util/custom_flushbar.dart';
import 'package:tracklet_pro/core/utils/validators/validators.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  void _submit(BuildContext context) {
    final nameController = TextEditingController();
    final designationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
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
                  Provider.of<EmployeeProvider>(
                    context,
                    listen: false,
                  ).addEmployee(name, designation);

                  Navigator.pop(dialogContext);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      CustomFlushbar.showSuccess(context, message: 'Employee added successfully');
                    }
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      CustomFlushbar.showError(context, message: 'Please fill all required fields');
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              'Employees',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'ID',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ) ?? const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Name',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ) ?? const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Designation',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ) ?? const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(width: 80, child: Text('')),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Builder(
                builder: (context) {
                  final provider = Provider.of<EmployeeProvider>(context);
                  final list = provider.employees;

                  if (list.isEmpty) {
                    return const Center(child: Text('No employees yet.'));
                  }

                  return ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final e = list[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              key: ValueKey(e.id),
                              child: Text(e.id),
                            ),
                            const SizedBox(width: 8),
                            Expanded(flex: 3, child: Text(e.name)),
                            const SizedBox(width: 8),
                            Expanded(flex: 3, child: Text(e.designation)),
                            const SizedBox(width: 8),
                            IconButton(
                              tooltip: 'Rename',
                              icon: Icon(
                                Icons.edit_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () async {
                                final controller = TextEditingController(
                                  text: e.name,
                                );
                                final newName = await showDialog<String>(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text('Rename Employee'),
                                      content: ValidationBuilder.nameTextField(
                                        controller: controller,
                                        hintText: 'Enter new name',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            final v = controller.text.trim();
                                            if (v.isNotEmpty) {
                                              Navigator.pop(ctx, v);
                                            }
                                          },
                                          child: const Text('Save'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (newName != null &&
                                    newName.trim().isNotEmpty) {
                                  provider.renameEmployee(e.id, newName.trim());
                                  // Use a new context for the flushbar
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    if (context.mounted) {
                                      CustomFlushbar.showSuccess(
                                        context,
                                        message: 'Employee ${e.id} renamed',
                                      );
                                    }
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Delete Employee'),
                                    content: Text(
                                      'Are you sure you want to delete ${e.id}?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirm == true) {
                                  provider.deleteEmployee(e.id);
                                  // Use a new context for the flushbar
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    if (context.mounted) {
                                      CustomFlushbar.showError(
                                        context,
                                        message: 'Employee ${e.id} deleted',
                                      );
                                    }
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: CustomButton(
                text: 'Add Employee',
                onPressed: () => _submit(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
