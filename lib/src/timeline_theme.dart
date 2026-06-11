import 'package:flutter/material.dart';

enum LineStyle { solid, dotted, dashed, gradient }

enum IndicatorStyle { circle, icon, number, custom }

enum TimelineAxis { vertical, horizontal, responsive }

enum ConnectorAnimation {
  growDown, growUp, growOut, wave, pulse, draw, fadeIn, bounce,
  stagger, wipe, glow, ripple, morph, slideIn,
}

enum TimelineEffect { none, glow, shimmer, sparkle }

class TimelineThemeData {
  final Color? lineColor;
  final Color? lineGradientStart;
  final Color? lineGradientEnd;
  final double lineWidth;
  final LineStyle lineStyle;
  final IndicatorStyle indicatorStyle;
  final Color? indicatorColor;
  final double indicatorSize;
  final Color? cardBackground;
  final double cardElevation;
  final EdgeInsetsGeometry cardPadding;
  final BorderRadiusGeometry cardBorderRadius;
  final TextStyle? titleStyle;
  final TextStyle? dateStyle;
  final TextStyle? descriptionStyle;
  final Duration animationDuration;
  final Curve animationCurve;
  final EdgeInsetsGeometry padding;
  final double spacingBetweenEvents;
  final Color? backgroundColor;
  final Color? timelineBackground;
  final ConnectorAnimation connectorAnimation;
  final TimelineEffect effect;

  const TimelineThemeData({
    this.lineColor,
    this.lineGradientStart,
    this.lineGradientEnd,
    this.lineWidth = 2.5,
    this.lineStyle = LineStyle.solid,
    this.connectorAnimation = ConnectorAnimation.growDown,
    this.effect = TimelineEffect.none,
    this.indicatorStyle = IndicatorStyle.circle,
    this.indicatorColor,
    this.indicatorSize = 32.0,
    this.cardBackground,
    this.cardElevation = 1.0,
    this.cardPadding = const EdgeInsets.all(16),
    this.cardBorderRadius = const BorderRadius.all(Radius.circular(12)),
    this.titleStyle,
    this.dateStyle,
    this.descriptionStyle,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.easeInOut,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.spacingBetweenEvents = 0,
    this.backgroundColor,
    this.timelineBackground,
  });

  TimelineThemeData copyWith({
    Color? lineColor,
    Color? lineGradientStart,
    Color? lineGradientEnd,
    double? lineWidth,
    LineStyle? lineStyle,
    ConnectorAnimation? connectorAnimation,
    TimelineEffect? effect,
    IndicatorStyle? indicatorStyle,
    Color? indicatorColor,
    double? indicatorSize,
    Color? cardBackground,
    double? cardElevation,
    EdgeInsetsGeometry? cardPadding,
    BorderRadiusGeometry? cardBorderRadius,
    TextStyle? titleStyle,
    TextStyle? dateStyle,
    TextStyle? descriptionStyle,
    Duration? animationDuration,
    Curve? animationCurve,
    EdgeInsetsGeometry? padding,
    double? spacingBetweenEvents,
    Color? backgroundColor,
    Color? timelineBackground,
  }) {
    return TimelineThemeData(
      lineColor: lineColor ?? this.lineColor,
      lineGradientStart: lineGradientStart ?? this.lineGradientStart,
      lineGradientEnd: lineGradientEnd ?? this.lineGradientEnd,
      lineWidth: lineWidth ?? this.lineWidth,
      lineStyle: lineStyle ?? this.lineStyle,
      connectorAnimation: connectorAnimation ?? this.connectorAnimation,
      effect: effect ?? this.effect,
      indicatorStyle: indicatorStyle ?? this.indicatorStyle,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      cardBackground: cardBackground ?? this.cardBackground,
      cardElevation: cardElevation ?? this.cardElevation,
      cardPadding: cardPadding ?? this.cardPadding,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      titleStyle: titleStyle ?? this.titleStyle,
      dateStyle: dateStyle ?? this.dateStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      padding: padding ?? this.padding,
      spacingBetweenEvents: spacingBetweenEvents ?? this.spacingBetweenEvents,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      timelineBackground: timelineBackground ?? this.timelineBackground,
    );
  }
}
