import 'package:flutter/material.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/features/plant/presentation/bottom_navbar/plant_bottom_navbar.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 180),

                  // Illustration
                  SizedBox(
                    height: 200,
                    child:
                        // QR Code Image
                        Image.asset(
                          'assets/images/onboardingImage.png',
                          width: 234.07481384277344,
                          height: 239.71958923339844,
                          fit: BoxFit.contain,
                        ),
                  ),

                  const SizedBox(height: 100),

                  // Title
                  Text('Track Every Cylinder', style: textTheme.displayMedium),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Scan QR codes to track every cylinder easily \n and securely.',
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(
                    height: 60,
                  ), // Add extra space before the button
                ],
              ),
            ),
          ),

          // Bottom Button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: CustomButton(
              onPressed: () {
                // Navigate to login screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const PlantBottomNavbar(),
                  ),
                );
              },
              text: 'GET STARTED',
            ),
          ),
        ],
      ),
    );
  }
}
