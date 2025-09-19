import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;
  final bool isSmall;
  final bool isLarge;
  final bool withTrackletStyle;

  const LoadingIndicator({
    super.key,
    this.size = 24.0,
    this.color,
    this.strokeWidth = 2.0,
    this.isSmall = false,
    this.isLarge = false,
    this.withTrackletStyle = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSize = isSmall ? 20.0 : (isLarge ? 32.0 : size);
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.primaryColor;

    return Center(
      child: SizedBox(
        width: effectiveSize,
        height: effectiveSize,
        child: withTrackletStyle
            ? const _TrackletLoadingIndicator()
            : CircularProgressIndicator(
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
              ),
      ),
    );
  }

  // Predefined sizes for convenience
  factory LoadingIndicator.small({
    Color? color,
    bool withTrackletStyle = true,
  }) {
    return LoadingIndicator(
      isSmall: true,
      color: color,
      withTrackletStyle: withTrackletStyle,
    );
  }

  factory LoadingIndicator.large({
    Color? color,
    bool withTrackletStyle = true,
  }) {
    return LoadingIndicator(
      isLarge: true,
      color: color,
      withTrackletStyle: withTrackletStyle,
    );
  }

  // For buttons and small spaces
  static Widget inline({
    double size = 16.0,
    Color? color,
    bool withTrackletStyle = true,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: withTrackletStyle
          ? const _TrackletLoadingIndicator()
          : CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Colors.grey[400]!,
              ),
            ),
    );
  }

  // Full screen loading
  static Widget fullScreen({String? message}) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator.large(withTrackletStyle: true),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TrackletLoadingIndicator extends StatefulWidget {
  const _TrackletLoadingIndicator();

  @override
  State<_TrackletLoadingIndicator> createState() =>
      _TrackletLoadingIndicatorState();
}

class _TrackletLoadingIndicatorState extends State<_TrackletLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final secondaryColor = theme.colorScheme.secondary;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(40, 40),
          painter: _TrackletLoadingPainter(
            progress: _animation.value,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
          ),
        );
      },
    );
  }
}

class _TrackletLoadingPainter extends CustomPainter {
  final double progress;
  final Color primaryColor;
  final Color secondaryColor;

  _TrackletLoadingPainter({
    required this.progress,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Draw track (background circle)
    paint.color = primaryColor;
    canvas.drawCircle(center, radius, paint);

    // Draw animated arc
    paint.color = primaryColor;
    final sweepAngle = 2.0 * 3.14 * 0.7; // 70% of the circle
    final startAngle =
        -3.14 / 2 + (progress * 3.14 * 2); // Rotating start angle

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );

    // Add a small dot at the end of the arc
    final dotX =
        center.dx + radius * (1.0 + progress * 0.3) * (progress < 0.5 ? 1 : -1);
    final dotY =
        center.dy + radius * (1.0 - progress * 2.0) * (progress < 0.5 ? 1 : -1);

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(dotX, dotY), 2.5, paint);
  }

  @override
  bool shouldRepaint(covariant _TrackletLoadingPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
