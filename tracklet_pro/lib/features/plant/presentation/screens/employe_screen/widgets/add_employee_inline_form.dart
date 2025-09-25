import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/utils/snackbar_util/custom_flushbar.dart';
import 'package:tracklet_pro/core/utils/validators/validators.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

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
    if (!FormValidator.validateFormKey(_formKey)) return;
    final name = _nameController.text.trim();
    final designation = _designationController.text.trim();
    final provider = Provider.of<EmployeeProvider>(context, listen: false);
    provider.addEmployee(name, designation);
    provider.setSelectedTab(AttendanceTab.total);
    _nameController.clear();
    _designationController.clear();
    FormValidator.resetForm(_formKey);
    CustomFlushbar.showSuccess(context, message: 'Employee "$name" added');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: ValidationBuilder.nameTextField(
              controller: _nameController,
              hintText: 'Enter employee name',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ValidationBuilder.requiredTextField(
              controller: _designationController,
              hintText: 'Enter designation',
              validator: Validators.validateDesignation,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 160,
            child: CustomButton(text: 'Add Employee', onPressed: _submit),
          ),
        ],
      ),
    );
  }
}
