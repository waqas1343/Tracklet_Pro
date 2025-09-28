import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/setting_screen/provider/manage_plant_provider.dart';
import 'package:tracklet_pro/core/constants/dimens.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text('Manage Plant', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.gap8),
              Text('Plant Information', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: Dimens.gap16),

              Text('Plant Image:', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: Dimens.gap8),
              GestureDetector(
                onTap: () => provider.pickImage(context),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).dividerColor, style: BorderStyle.solid, width: 1, strokeAlign: BorderSide.strokeAlignInside),
                  ),
                  child: const DottedBorderPlaceholder(),
                ),
              ),

              const SizedBox(height: Dimens.gap16),
              Text('Plant Name:', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: Dimens.gap6),
              TextField(
                controller: provider.plantNameController,
                decoration: const InputDecoration(hintText: 'Enter Plant Name'),
              ),

              const SizedBox(height: Dimens.gap12),
              Text('Contact Number:', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: Dimens.gap6),
              TextField(
                keyboardType: TextInputType.phone,
                controller: provider.contactController,
                decoration: const InputDecoration(hintText: '03xx xxxxxxx'),
              ),

              const SizedBox(height: Dimens.gap12),
              Text('Address', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: Dimens.gap6),
              TextField(
                controller: provider.addressController,
                decoration: const InputDecoration(hintText: 'Enter Address'),
                maxLines: 3,
              ),

              const SizedBox(height: Dimens.gap22),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.isSaving ? null : () => provider.saveChanges(context),
                  child: provider.isSaving
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DottedBorderPlaceholder extends StatelessWidget {
  const DottedBorderPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_outlined, size: 36, color: scheme.primary),
            const SizedBox(height: 8),
            Text('Upload Plant Image', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(
              'Add a logo or image to help identify your plant easily.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
