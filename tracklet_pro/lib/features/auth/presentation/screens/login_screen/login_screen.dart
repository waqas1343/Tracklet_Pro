import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/auth/presentation/providers/password_visibility_provider.dart';
import 'package:tracklet_pro/features/onboarding/onboarding_screen.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';
import 'package:tracklet_pro/shared/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'waqas@tracklet.com');
    _passwordController = TextEditingController(text: '5904');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordProvider = context.watch<PasswordVisibilityProvider>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content (Center)
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo and Title
                    Text(
                      'Login to Your Account',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter the email and password provided by\nyour admin.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Email Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: !passwordProvider.isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordProvider.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          passwordProvider.togglePasswordVisibility();
                        },
                      ),
                    ),

                    // Remember Me Checkbox
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        Text(
                          'Remember Me',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Login Button
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: CustomButton(
                onPressed: () {
                  // Navigate to Onboarding Screen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                  );
                },
                text: 'LOGIN',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
