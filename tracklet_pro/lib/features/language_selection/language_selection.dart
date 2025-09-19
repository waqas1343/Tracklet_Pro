import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:tracklet_pro/features/language_selection/providers/language_provider.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Choose Your Language', style: textTheme.displayMedium),
                const SizedBox(height: 8),
                Text(
                  'Select your preferred language to\ncontinue using the app.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LanguageButton(
                      language: 'Eng',
                      isSelected: languageProvider.selectedLanguage == 'Eng',
                      onTap: () => languageProvider.setLanguage('Eng'),
                    ),
                    const SizedBox(width: 32),
                    _LanguageButton(
                      language: 'اردو',
                      isSelected: languageProvider.selectedLanguage == 'اردو',
                      onTap: () => languageProvider.setLanguage('اردو'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Fixed Bottom Button
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: CustomButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              text: 'CONTINUE',
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageButton({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.softBlue
              : AppColors.lightBlueBackground,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          language,
          style: textTheme.titleLarge?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
