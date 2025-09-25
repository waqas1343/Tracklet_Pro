import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

/// Extension methods for [Widget] to add common functionality
extension WidgetExtensions on Widget {
  /// Adds padding to the widget
  Padding paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  /// Adds symmetric padding to the widget
  Padding paddingSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Adds only padding to the widget
  Padding paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  /// Wraps the widget with a [GestureDetector]
  GestureDetector onTap(
    GestureTapCallback onTap, {
    Key? key,
  }) =>
      GestureDetector(
        key: key,
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: this,
      );

  /// Wraps the widget with a [Visibility] widget
  Visibility showIf(bool visible, {bool maintainState = true}) => Visibility(
        visible: visible,
        maintainState: maintainState,
        child: this,
      );

  /// Wraps the widget with a [Center] widget
  Center center({double? width, double? height}) => Center(
        widthFactor: width,
        heightFactor: height,
        child: this,
      );

  /// Wraps the widget with an [Opacity] widget
  Opacity opacity(double opacity) => Opacity(
        opacity: opacity,
        child: this,
      );

  /// Wraps the widget with an [Expanded] widget
  Expanded expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  /// Wraps the widget with a [SizedBox] with the given width and height
  SizedBox sized({double? width, double? height}) => SizedBox(
        width: width,
        height: height,
        child: this,
      );

  /// Wraps the widget with a [Container] with the given decoration
  Container withDecoration(Decoration decoration) => Container(
        decoration: decoration,
        child: this,
      );

  /// Wraps the widget with a [Material] widget
  Material material({
    double elevation = 0.0,
    Color? color,
    Color? shadowColor,
    ShapeBorder? shape,
    BorderRadiusGeometry? borderRadius,
  }) =>
      Material(
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        shape: shape ??
            (borderRadius != null
                ? RoundedRectangleBorder(borderRadius: borderRadius)
                : null),
        child: this,
      );

  /// Wraps the widget with a [Card] widget
  Card card({
    Key? key,
    Color? color,
    Color? shadowColor,
    double? elevation,
    ShapeBorder? shape,
    bool borderOnForeground = true,
    EdgeInsetsGeometry? margin,
    Clip? clipBehavior,
    bool semanticContainer = true,
  }) =>
      Card(
        key: key,
        color: color,
        shadowColor: shadowColor,
        elevation: elevation,
        shape: shape,
        borderOnForeground: borderOnForeground,
        margin: margin,
        clipBehavior: clipBehavior,
        semanticContainer: semanticContainer,
        child: this,
      );

  /// Wraps the widget with a [Hero] widget
  Hero hero(Object tag, {Key? key}) => Hero(
        tag: tag,
        child: this,
      );

  /// Wraps the widget with a [Tooltip] widget
  Widget tooltip(
    String message, {
    Key? key,
    Decoration? decoration,
    BoxConstraints? constraints,
    bool? preferBelow,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    Duration showDuration = const Duration(milliseconds: 1500),
    Duration? waitDuration,
    double? verticalOffset = 10.0,
  }) =>
      Tooltip(
        key: key,
        message: message,
        decoration: decoration,
        constraints: constraints,
        padding: padding,
        preferBelow: preferBelow,
        textStyle: textStyle,
        showDuration: showDuration,
        waitDuration: waitDuration ?? const Duration(milliseconds: 500),
        verticalOffset: verticalOffset ?? 10.0,
        child: this,
      );

  /// Wraps the widget with a [SafeArea] widget
  SafeArea safeArea({
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) =>
      SafeArea(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        minimum: minimum,
        maintainBottomViewPadding: maintainBottomViewPadding,
        child: this,
      );

  /// Wraps the widget with a [ClipRRect] widget
  ClipRRect clipRRect({
    BorderRadius borderRadius = BorderRadius.zero,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) =>
      ClipRRect(
        borderRadius: borderRadius,
        clipper: clipper,
        clipBehavior: clipBehavior,
        child: this,
      );

  /// Wraps the widget with a [RotatedBox] widget
  RotatedBox rotatedBox(int quarterTurns) => RotatedBox(
        quarterTurns: quarterTurns,
        child: this,
      );

  /// Wraps the widget with a [FittedBox] widget
  FittedBox fittedBox({
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    Clip clipBehavior = Clip.none,
  }) =>
      FittedBox(
        fit: fit,
        alignment: alignment,
        clipBehavior: clipBehavior,
        child: this,
      );

  /// Wraps the widget with a [BackdropFilter] widget
  Widget backdropFilter(ImageFilter filter) => Stack(
        children: [
          this,
          BackdropFilter(
            filter: filter,
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.1),
            ),
          ),
        ],
      );
}
