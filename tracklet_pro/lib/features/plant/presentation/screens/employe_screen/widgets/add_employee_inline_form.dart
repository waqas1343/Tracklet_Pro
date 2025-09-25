import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';
import 'package:tracklet_pro/constant/utils/snakbar_util/custom_flushbar.dart';

class AddEmployeeInlineForm extends StatefulWidget {
  const AddEmployeeInlineForm({super.key});

  @override
  State<AddEmployeeInlineForm> createState() => _AddEmployeeInlineFormState();
}

class _AddEmployeeInlineFormState extends State<AddEmployeeInlineForm> {
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    final provider = Provider.of<EmployeeProvider>(context, listen: false);
    provider.addEmployee(name, designation);
    provider.setSelectedTab(AttendanceTab.total);
    _nameController.clear();
    _designationController.clear();
    CustomFlushbar.showSuccess(context, message: 'Employee "$name" added');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Employee Name',
                hintText: 'Enter employee name',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Name is required';
                return null;
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: _designationController,
              decoration: const InputDecoration(
                labelText: 'Designation',
                hintText: 'Enter designation',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Designation is required';
                return null;
              },
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 160,
            child: CustomButton(
              text: 'Add Employee',
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
