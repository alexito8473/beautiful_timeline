import 'package:flutter/material.dart';
import 'timeline_theme.dart';
import 'animations.dart';

class TimelineConnector extends StatelessWidget {
  final TimelineThemeData theme;
  final bool isLast;
  final int index;
  final bool reverse;
  final TimelineAxis axis;

  const TimelineConnector({
    super.key,
    required this.theme,
    this.isLast = false,
    this.index = 0,
    this.reverse = false,
    this.axis = TimelineAxis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if (isLast) return const SizedBox.shrink();

    var animationStyle = theme.connectorAnimation;
    if (reverse) {
      switch (animationStyle) {
        case ConnectorAnimation.growDown:
          animationStyle = ConnectorAnimation.growUp;
        case ConnectorAnimation.growUp:
          animationStyle = ConnectorAnimation.growDown;
        default:
          break;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final lineLength = axis == TimelineAxis.horizontal
            ? (constraints.maxWidth.isFinite ? constraints.maxWidth : 200.0)
            : (constraints.maxHeight.isFinite ? constraints.maxHeight : 200.0);
        return AnimatedConnector(
          progress: 1.0,
          height: lineLength,
          color: theme.lineColor ?? Colors.grey.shade300,
          gradientStart: theme.lineGradientStart,
          gradientEnd: theme.lineGradientEnd,
          thickness: theme.lineWidth,
          style: theme.lineStyle,
          animationStyle: animationStyle,
          axis: axis,
        );
      },
    );
  }
}
