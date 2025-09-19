import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/constants/colors/app_colors.dart';
import 'package:tracklet_pro/core/constants/dimensions/app_dimensions.dart';
import 'package:tracklet_pro/features/splash/providers/splash_provider.dart';
import 'package:tracklet_pro/shared/widgets/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashProvider()..init(context),
      child: const _SplashContent(),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, splashProvider, _) {
        return Scaffold(
          backgroundColor: AppColors.darkBlue,
          body: FadeTransition(
            opacity: splashProvider.fadeAnimation,
            child: const _SplashUI(),
          ),
        );
      },
    );
  }
}

class _SplashUI extends StatelessWidget {
  const _SplashUI();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Tracklet Pro',
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppDimensions.fontXLarge,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          LoadingIndicator(
            color: AppColors.white,
            isLarge: true,
          ),
        ],
      ),
    );
  }
}
