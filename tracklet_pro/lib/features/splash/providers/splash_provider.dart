import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tracklet_pro/features/language_selection/language_selection.dart';

class SplashProvider extends ChangeNotifier {
  late final AnimationController _controller;
  late Animation<double> _fadeAnimation;
  Timer? _timer;
  bool _isInitialized = false;
  BuildContext? _context;

  AnimationController get controller {
    assert(_isInitialized, 'SplashProvider must be initialized with initAnimation');
    return _controller;
  }

  Animation<double> get fadeAnimation {
    assert(_isInitialized, 'SplashProvider must be initialized with initAnimation');
    return _fadeAnimation;
  }

  void init(BuildContext context) {
    _context = context;
    _isInitialized = true;
    _startAnimation();
    _startNavigationTimer();
  }

  void _startAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: _getTickerProvider(),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  TickerProvider _getTickerProvider() {
    final context = _context;
    if (context == null) {
      throw FlutterError('Context is not set. Call init() first.');
    }
    return context.findAncestorStateOfType<TickerProviderStateMixin>()!;
  }

  void _startNavigationTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), _navigateToLogin);
  }

  void _navigateToLogin() {
    void navigateToNextScreen() {
      if (_context != null) {
        Navigator.of(_context!).pushReplacement(
          MaterialPageRoute(builder: (context) => const LanguageSelection()),
        );
      }
    }
    navigateToNextScreen();
  }


  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _isInitialized = false;
    super.dispose();
  }
}
