import 'package:flutter/material.dart';
import 'timeline_theme.dart';

class TimelineIndicator extends StatelessWidget {
  final TimelineThemeData theme;
  final IconData? icon;
  final double? size;
  final Color? color;
  final Widget? customWidget;
  final int? number;

  const TimelineIndicator({
    super.key,
    required this.theme,
    this.icon,
    this.size,
    this.color,
    this.customWidget,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    if (customWidget != null) return customWidget!;

    final indicatorSize = size ?? theme.indicatorSize;
    final indicatorColor = color ?? theme.indicatorColor ?? theme.lineColor ?? Colors.grey;

    Widget indicator;
    switch (theme.indicatorStyle) {
      case IndicatorStyle.circle:
        indicator = Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: indicatorColor,
            shape: BoxShape.circle,
            boxShadow: theme.cardElevation > 0
                ? [
                    BoxShadow(
                      color: indicatorColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: icon != null
              ? Icon(icon, color: Colors.white, size: indicatorSize * 0.55)
              : null,
        );
      case IndicatorStyle.icon:
        indicator = Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: indicatorColor,
            shape: BoxShape.circle,
            boxShadow: theme.cardElevation > 0
                ? [
                    BoxShadow(
                      color: indicatorColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon ?? Icons.circle,
            color: Colors.white,
            size: indicatorSize * 0.55,
          ),
        );
      case IndicatorStyle.number:
        indicator = Container(
          width: indicatorSize,
          height: indicatorSize,
          alignment: Alignment.center,
          child: Text(
            '${number ?? (icon?.hashCode ?? 0).abs() % 100}',
            style: TextStyle(
              color: indicatorColor,
              fontWeight: FontWeight.bold,
              fontSize: indicatorSize * 0.4,
            ),
          ),
        );
      case IndicatorStyle.custom:
        indicator = const SizedBox.shrink();
    }

    if (theme.effect == TimelineEffect.glow) {
      indicator = Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: indicatorSize * 2.2,
            height: indicatorSize * 2.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: indicatorColor.withValues(alpha: 0.12),
              boxShadow: [
                BoxShadow(
                  color: indicatorColor.withValues(alpha: 0.2),
                  blurRadius: 16,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          indicator,
        ],
      );
    }

    if (theme.effect == TimelineEffect.sparkle) {
      indicator = Stack(
        alignment: Alignment.center,
        children: [
          indicator,
          _SparkleDot(offset: Offset(-indicatorSize * 0.6, -indicatorSize * 0.6), color: indicatorColor),
          _SparkleDot(offset: Offset(indicatorSize * 0.6, -indicatorSize * 0.4), color: indicatorColor),
          _SparkleDot(offset: Offset(-indicatorSize * 0.5, indicatorSize * 0.6), color: indicatorColor),
          _SparkleDot(offset: Offset(indicatorSize * 0.7, indicatorSize * 0.5), color: indicatorColor),
        ],
      );
    }

    return indicator;
  }
}

class _SparkleDot extends StatelessWidget {
  final Offset offset;
  final Color color;

  const _SparkleDot({required this.offset, required this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
