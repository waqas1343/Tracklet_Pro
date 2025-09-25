import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/utils/snackbar_util/custom_flushbar.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final designation = _designationController.text.trim();
    Provider.of<EmployeeProvider>(
      context,
      listen: false,
    ).addEmployee(name, designation);
    _nameController.clear();
    _designationController.clear();

    CustomFlushbar.showSuccess(context, message: 'Employee added successfully');
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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Employee Name',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter employee name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Designation',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _designationController,
                    decoration: const InputDecoration(
                      hintText: 'Enter designation (e.g., Supervisor)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a designation';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(text: 'Add Employee', onPressed: _submit),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Employees',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.grey.shade200,
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Designation',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(width: 80, child: Text('')),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer<EmployeeProvider>(
                builder: (context, provider, _) {
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
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.blueGrey,
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
                                  CustomFlushbar.showSuccess(
                                    context,
                                    message: 'Employee ${e.id} renamed',
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
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
                                  CustomFlushbar.showError(
                                    context,
                                    message: 'Employee ${e.id} deleted',
                                  );
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
          ],
        ),
      ),
    );
  }
}
