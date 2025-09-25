import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/core/utils/validators/validators.dart';
import 'package:tracklet_pro/features/auth/presentation/providers/login_provider.dart';
import 'package:tracklet_pro/features/auth/presentation/providers/password_visibility_provider.dart';
import 'package:tracklet_pro/features/onboarding/onboarding_screen.dart';
import 'package:tracklet_pro/shared/widgets/custom_button.dart';
import 'package:tracklet_pro/shared/widgets/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: const _LoginContent(),
    );
  }
}

class _LoginContent extends StatefulWidget {
  const _LoginContent();

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

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

  Future<void> _login() async {
    final loginProvider = context.read<LoginProvider>();

    if (!FormValidator.validateFormKey(_formKey)) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!loginProvider.isFormValid(email, password)) {
      loginProvider.clearError();
      return;
    }

    final success = await loginProvider.login(email, password);

    if (success && mounted) {
      // Navigate to Onboarding Screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content (Center)
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
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
                      ValidationBuilder.emailTextField(
                        controller: _emailController,
                        hintText: 'Enter email address',
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
                      ValidationBuilder.passwordTextField(
                        controller: _passwordController,
                        hintText: 'Enter password',
                        obscureText: !context.watch<PasswordVisibilityProvider>().isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            context.watch<PasswordVisibilityProvider>().isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            context.read<PasswordVisibilityProvider>().togglePasswordVisibility();
                          },
                        ),
                      ),

                      // Error Message
                      if (loginProvider.errorMessage != null)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Theme.of(context).colorScheme.error),
                          ),
                          child: Text(
                            loginProvider.errorMessage!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ) ?? TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Remember Me Checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            value: loginProvider.rememberMe,
                            onChanged: (value) {
                              loginProvider.toggleRememberMe(value);
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
            ),

            // Login Button
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: loginProvider.isLoading
                  ? LoadingIndicator(
                      color: Theme.of(context).primaryColor,
                      isLarge: false,
                    )
                  : CustomButton(
                      onPressed: () => _login(),
                      text: 'LOGIN',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
