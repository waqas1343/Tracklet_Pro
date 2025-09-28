import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/provider/manage_plant_provider.dart';

class ManagePlantScreen extends StatelessWidget {
  const ManagePlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManagePlantProvider(),
      child: const _ManagePlantView(),
    );
  }
}

class _ManagePlantView extends StatelessWidget {
  const _ManagePlantView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ManagePlantProvider>();
    final primaryDark = const Color(0xff1f3f6a);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Manage Plant', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text('Plant Information', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),

              const Text('Plant Image:'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => provider.pickImage(context),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid, width: 1, strokeAlign: BorderSide.strokeAlignInside),
                  ),
                  child: DottedBorderPlaceholder(primaryDark: primaryDark),
                ),
              ),

              const SizedBox(height: 16),
              const Text('Plant Name:'),
              const SizedBox(height: 6),
              TextField(
                controller: provider.plantNameController,
                decoration: _inputDecoration('Enter Plant Name', primaryDark),
              ),

              const SizedBox(height: 12),
              const Text('Contact Number:'),
              const SizedBox(height: 6),
              TextField(
                keyboardType: TextInputType.phone,
                controller: provider.contactController,
                decoration: _inputDecoration('03xx xxxxxxx', primaryDark),
              ),

              const SizedBox(height: 12),
              const Text('Address'),
              const SizedBox(height: 6),
              TextField(
                controller: provider.addressController,
                decoration: _inputDecoration('Enter Address', primaryDark),
                maxLines: 3,
              ),

              const SizedBox(height: 22),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.isSaving ? null : () => provider.saveChanges(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: provider.isSaving
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, Color primaryDark) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryDark, width: 1.5),
      ),
    );
  }
}

class DottedBorderPlaceholder extends StatelessWidget {
  final Color primaryDark;
  const DottedBorderPlaceholder({super.key, required this.primaryDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined, size: 36, color: primaryDark),
            const SizedBox(height: 8),
            const Text('Upload Plant Image', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text(
              'Add a logo or image to help identify your plant easily.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
