import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/order/data/model/order_model.dart';

class NewOrderFormProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final instructionController = TextEditingController();
  final qty50Controller = TextEditingController(text: '0');
  final qty100Controller = TextEditingController(text: '0');
  final qty20Controller = TextEditingController(text: '0');

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    instructionController.dispose();
    qty50Controller.dispose();
    qty100Controller.dispose();
    qty20Controller.dispose();
    super.dispose();
  }

  int _parseInt(String v) => int.tryParse(v.trim()) ?? 0;

  int get totalKg => 50 * _parseInt(qty50Controller.text) + 100 * _parseInt(qty100Controller.text) + 20 * _parseInt(qty20Controller.text);

  List<String> get requestedItems {
    final items = <String>[];
    final q50 = _parseInt(qty50Controller.text);
    final q100 = _parseInt(qty100Controller.text);
    final q20 = _parseInt(qty20Controller.text);
    if (q50 > 0) items.add('50 KG ($q50)');
    if (q100 > 0) items.add('100 KG ($q100)');
    if (q20 > 0) items.add('20 KG ($q20)');
    return items;
  }

  String? validate() {
    if (nameController.text.trim().isEmpty) return 'Name is required';
    if (requestedItems.isEmpty) return 'Please add at least one quantity';
    return null;
  }

  OrderModel buildOrderModel() {
    return OrderModel(
      traderName: nameController.text.trim(),
      requestedItems: requestedItems,
      totalKg: totalKg,
      totalBill: 0,
      status: 'New',
      specialInstruction: instructionController.text.trim().isEmpty ? null : instructionController.text.trim(),
      location: locationController.text.trim().isEmpty ? null : locationController.text.trim(),
      driverName: '-',
    );
  }
}
