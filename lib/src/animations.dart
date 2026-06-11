import 'dart:math' show sin, pi;
import 'package:flutter/material.dart';
import 'timeline_theme.dart';
import 'animation_controller.dart';

class _AnimatedTimelineEntry extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration duration;
  final Curve curve;

  const _AnimatedTimelineEntry({
    required this.child,
    required this.index,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeInOut,
  });

  @override
  State<_AnimatedTimelineEntry> createState() => _AnimatedTimelineEntryState();
}

class _AnimatedTimelineEntryState extends State<_AnimatedTimelineEntry>
    with SingleTickerProviderStateMixin {
  AnimationController? _localController;
  Animation<double>? _localFade;
  Animation<Offset>? _localSlide;

  @override
  void initState() {
    super.initState();
    _initLocalController();
  }

  void _initLocalController() {
    _localController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _localFade = CurvedAnimation(parent: _localController!, curve: widget.curve);
    _localSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _localController!, curve: widget.curve));
    Future.delayed(Duration(milliseconds: 80 * widget.index), () {
      if (mounted && _localController != null) {
        _localController!.forward();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shared = TimelineAnimationScope.of(context);
    if (shared != null && _localController != null) {
      _localController?.dispose();
      _localController = null;
      _localFade = null;
      _localSlide = null;
    }
  }

  @override
  void dispose() {
    _localController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shared = TimelineAnimationScope.of(context);
    if (shared != null) {
      return _SharedEntryAnimation(
        index: widget.index,
        controller: shared,
        curve: widget.curve,
        child: widget.child,
      );
    }

    if (_localFade == null || _localSlide == null) {
      return widget.child;
    }

    return FadeTransition(
      opacity: _localFade!,
      child: SlideTransition(
        position: _localSlide!,
        child: widget.child,
      ),
    );
  }
}

class _SharedEntryAnimation extends StatefulWidget {
  final Widget child;
  final int index;
  final TimelineAnimationController controller;
  final Curve curve;

  const _SharedEntryAnimation({
    required this.child,
    required this.index,
    required this.controller,
    required this.curve,
  });

  @override
  State<_SharedEntryAnimation> createState() => _SharedEntryAnimationState();
}

class _SharedEntryAnimationState extends State<_SharedEntryAnimation> {

  @override
  Widget build(BuildContext context) {
    final staggerBase = 0.12;
    final staggerSpan = 0.35;
    final start = widget.index * staggerBase;
    final end = start + staggerSpan;

    return ListenableBuilder(
      listenable: widget.controller.controller,
      builder: (context, _) {
        final raw = (widget.controller.value - start) / (end - start);
        final clamped = raw.clamp(0.0, 1.0);
        final curved = Curves.easeOut.transform(clamped);

        return Opacity(
          opacity: curved,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - curved)),
            child: widget.child,
          ),
        );
      },
    );
  }
}

Widget animateEntry(Widget child, int index, {Duration? duration, Curve? curve}) {
  return _AnimatedTimelineEntry(
    index: index,
    duration: duration ?? const Duration(milliseconds: 400),
    curve: curve ?? Curves.easeInOut,
    child: child,
  );
}

class AnimatedConnector extends StatefulWidget {
  final double progress;
  final double height;
  final Color? color;
  final Color? gradientStart;
  final Color? gradientEnd;
  final double thickness;
  final LineStyle style;
  final int dotCount;
  final ConnectorAnimation animationStyle;
  final TimelineAxis axis;

  const AnimatedConnector({
    super.key,
    required this.progress,
    required this.height,
    this.color,
    this.gradientStart,
    this.gradientEnd,
    this.thickness = 2.5,
    this.style = LineStyle.solid,
    this.dotCount = 20,
    this.animationStyle = ConnectorAnimation.growDown,
    this.axis = TimelineAxis.vertical,
  });

  @override
  State<AnimatedConnector> createState() => _AnimatedConnectorState();
}

class _AnimatedConnectorState extends State<AnimatedConnector>
    with SingleTickerProviderStateMixin {
  AnimationController? _localController;

  @override
  void initState() {
    super.initState();
    _localController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _localController != null) {
        _localController!.forward();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shared = TimelineAnimationScope.of(context);
    if (shared != null && _localController != null) {
      _localController?.dispose();
      _localController = null;
    }
  }

  @override
  void dispose() {
    _localController?.dispose();
    super.dispose();
  }

  double _pulseValue(double v) {
    return 0.5 + 0.5 * sin(v * pi * 2 * 8);
  }

  double _bounceProgress(double t) {
    return t + 0.2 * (1 - t) * sin(t * pi * 4).abs();
  }

  @override
  Widget build(BuildContext context) {
    final shared = TimelineAnimationScope.of(context);

    return ListenableBuilder(
      listenable: shared?.controller ?? _localController!,
      builder: (context, _) {
        final rawValue = shared?.value ?? _localController?.value ?? 1.0;
        final animValue = rawValue * widget.progress;
        final pv = _pulseValue(rawValue);

        final isHorizontal = widget.axis == TimelineAxis.horizontal;
        final lineLength = widget.height;

        double displayLength;
        double paintProgress = animValue;
        switch (widget.animationStyle) {
          case ConnectorAnimation.growDown:
          case ConnectorAnimation.fadeIn:
          case ConnectorAnimation.stagger:
          case ConnectorAnimation.glow:
          case ConnectorAnimation.morph:
          case ConnectorAnimation.slideIn:
            displayLength = lineLength * animValue;
            break;
          case ConnectorAnimation.bounce:
            displayLength = lineLength;
            paintProgress = _bounceProgress(animValue)
                .clamp(0.0, 1.15);
            break;
          case ConnectorAnimation.growUp:
          case ConnectorAnimation.growOut:
          case ConnectorAnimation.wave:
          case ConnectorAnimation.pulse:
          case ConnectorAnimation.draw:
          case ConnectorAnimation.wipe:
          case ConnectorAnimation.ripple:
            displayLength = lineLength;
            break;
        }

        return SizedBox(
          width: isHorizontal ? displayLength : widget.thickness,
          height: isHorizontal ? widget.thickness : displayLength,
          child: CustomPaint(
            painter: _LinePainter(
              progress: paintProgress,
              pulseValue: pv,
              color: widget.color ?? Colors.grey.shade300,
              gradientStart: widget.gradientStart,
              gradientEnd: widget.gradientEnd,
              thickness: widget.thickness,
              style: widget.style,
              dotCount: widget.dotCount,
              animationStyle: widget.animationStyle,
              fullHeight: widget.height,
              isHorizontal: isHorizontal,
            ),
          ),
        );
      },
    );
  }
}

class _LinePainter extends CustomPainter {
  final double progress;
  final double pulseValue;
  final Color color;
  final Color? gradientStart;
  final Color? gradientEnd;
  final double thickness;
  final LineStyle style;
  final int dotCount;
  final ConnectorAnimation animationStyle;
  final double fullHeight;
  final bool isHorizontal;

  _LinePainter({
    required this.progress,
    required this.pulseValue,
    required this.color,
    this.gradientStart,
    this.gradientEnd,
    required this.thickness,
    this.style = LineStyle.solid,
    this.dotCount = 20,
    this.animationStyle = ConnectorAnimation.growDown,
    this.fullHeight = 0,
    this.isHorizontal = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (isHorizontal) {
      _paintHorizontal(canvas, size);
    } else {
      _paintVertical(canvas, size);
    }
  }

  void _paintVertical(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final h = size.height;
    final cx = size.width / 2;

    double startY, endY;
    switch (animationStyle) {
      case ConnectorAnimation.growDown:
      case ConnectorAnimation.bounce:
      case ConnectorAnimation.draw:
      case ConnectorAnimation.stagger:
      case ConnectorAnimation.glow:
      case ConnectorAnimation.morph:
      case ConnectorAnimation.slideIn:
        startY = 0;
        endY = h * progress;
        break;
      case ConnectorAnimation.fadeIn:
        paint.color = color.withValues(alpha: progress);
        startY = 0;
        endY = h * progress;
        break;
      case ConnectorAnimation.growUp:
        startY = h * (1 - progress);
        endY = h;
        break;
      case ConnectorAnimation.growOut:
        final center = h / 2;
        final half = (h / 2) * progress;
        startY = center - half;
        endY = center + half;
        break;
      case ConnectorAnimation.wave:
      case ConnectorAnimation.pulse:
      case ConnectorAnimation.wipe:
      case ConnectorAnimation.ripple:
        startY = 0;
        endY = h;
        break;
    }

    if (animationStyle == ConnectorAnimation.wave) {
      paint.color = color;
      final waveCount = 3.0;
      final path = Path();
      path.moveTo(cx, 0);
      for (double y = 0; y <= h; y += 2) {
        final waveOffset = sin((y / h * waveCount * pi * 2) + (progress * pi * 2)) * thickness * 1.5;
        path.lineTo(cx + waveOffset, y);
      }
      canvas.drawPath(path, paint);
      return;
    }

    if (animationStyle == ConnectorAnimation.pulse) {
      paint.color = color.withValues(alpha: pulseValue);
      canvas.drawLine(Offset(cx, 0), Offset(cx, h), paint);
      return;
    }

    if (animationStyle == ConnectorAnimation.draw) {
      paint.color = color;
      final totalLength = h;
      final drawnLength = totalLength * progress;
      final dashLen = 6.0;
      final gapLen = 4.0;
      double y = 0;
      bool drawing = true;
      double drawn = 0;
      while (y < h && drawn < drawnLength) {
        final segmentLen = drawing ? dashLen : gapLen;
        final segEnd = (y + segmentLen).clamp(0, h);
        if (drawing) {
          final segDrawEnd = (drawn + (segEnd - y)).clamp(0, drawnLength);
          final drawEnd = y + (segDrawEnd - drawn);
          canvas.drawLine(Offset(cx, y), Offset(cx, drawEnd), paint);
          drawn += segEnd - y;
        }
        y = segEnd.toDouble();
        drawing = !drawing;
      }
      return;
    }

    if (animationStyle == ConnectorAnimation.stagger) {
      paint.color = color;
      final totalLength = h;
      final drawnLength = totalLength * progress;
      final segLen = 10.0;
      final gapLen = 6.0;
      double y = 0;
      double drawn = 0;
      while (y < h && drawn < drawnLength) {
        final seg = (y + segLen).clamp(0.0, h).toDouble();
        final segDrawn = drawn + (seg - y);
        if (segDrawn <= drawnLength) {
          canvas.drawLine(Offset(cx, y), Offset(cx, seg), paint);
        } else {
          final partial = drawnLength - drawn;
          canvas.drawLine(Offset(cx, y), Offset(cx, y + partial), paint);
        }
        drawn += seg - y;
        y = (seg + gapLen).clamp(0.0, h).toDouble();
        drawn += gapLen;
      }
      return;
    }

    if (animationStyle == ConnectorAnimation.wipe) {
      paint.color = color.withValues(alpha: 1.0);
      canvas.save();
      canvas.clipRect(Rect.fromLTWH(0, 0, size.width, h * progress));
      canvas.drawLine(Offset(cx, 0), Offset(cx, h), paint);
      canvas.restore();
      return;
    }

    if (animationStyle == ConnectorAnimation.glow) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.3 * progress)
        ..strokeWidth = thickness * 4
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawLine(Offset(cx, 0), Offset(cx, h * progress), glowPaint);
      paint.color = color;
      canvas.drawLine(Offset(cx, 0), Offset(cx, h * progress), paint);
      return;
    }

    if (animationStyle == ConnectorAnimation.ripple) {
      paint.color = color;
      canvas.drawLine(Offset(cx, 0), Offset(cx, h), paint);
      final rippleY = h * progress;
      final ripplePaint = Paint()
        ..color = color.withValues(alpha: 0.6 * (1 - progress % 0.2).abs())
        ..strokeWidth = thickness * 2;
      canvas.drawCircle(Offset(cx, rippleY), thickness * 3, ripplePaint);
      return;
    }

    if (animationStyle == ConnectorAnimation.morph) {
      paint.color = color;
      final painted = startY + (endY - startY) * progress;
      if (progress < 0.5) {
        final dotSpacing = ((endY - startY) / dotCount).clamp(4.0, double.infinity).toDouble();
        for (double y = startY; y < startY + painted && y < endY; y += dotSpacing) {
          canvas.drawCircle(Offset(cx, y), thickness / 2, paint);
        }
      } else {
        canvas.drawLine(Offset(cx, startY), Offset(cx, startY + painted), paint);
      }
      return;
    }

    if (animationStyle == ConnectorAnimation.slideIn) {
      paint.color = color;
      final offset = thickness * 3 * (1 - progress);
      canvas.drawLine(Offset(cx - offset, startY), Offset(cx - offset, endY), paint);
      return;
    }

    if (startY >= endY) return;

    if (style == LineStyle.gradient && gradientStart != null && gradientEnd != null) {
      paint.shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [gradientStart!, gradientEnd!],
      ).createShader(Rect.fromLTWH(0, startY, size.width, endY - startY));
      canvas.drawLine(Offset(cx, startY), Offset(cx, endY), paint);
    } else if (style == LineStyle.dotted) {
      paint.color = color;
      final dotSpacing = ((endY - startY) / dotCount).clamp(4.0, double.infinity).toDouble();
      for (double y = startY; y < endY; y += dotSpacing) {
        canvas.drawCircle(Offset(cx, y), thickness / 2, paint);
      }
    } else if (style == LineStyle.dashed) {
      paint.color = color;
      final dashLength = 8.0;
      final gapLength = 6.0;
      double y = startY;
      bool drawing = true;
      while (y < endY) {
        final segmentEnd = (y + (drawing ? dashLength : gapLength)).clamp(startY, endY).toDouble();
        if (drawing) {
          canvas.drawLine(Offset(cx, y), Offset(cx, segmentEnd), paint);
        }
        y = segmentEnd.toDouble();
        drawing = !drawing;
      }
    } else {
      paint.color = color;
      canvas.drawLine(Offset(cx, startY), Offset(cx, endY), paint);
    }
  }

  void _paintHorizontal(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final cy = size.height / 2;

    double startX, endX;
    switch (animationStyle) {
      case ConnectorAnimation.growDown:
      case ConnectorAnimation.bounce:
      case ConnectorAnimation.draw:
      case ConnectorAnimation.stagger:
      case ConnectorAnimation.glow:
      case ConnectorAnimation.morph:
      case ConnectorAnimation.slideIn:
        startX = 0;
        endX = w * progress;
        break;
      case ConnectorAnimation.fadeIn:
        paint.color = color.withValues(alpha: progress);
        startX = 0;
        endX = w * progress;
        break;
      case ConnectorAnimation.growUp:
        startX = w * (1 - progress);
        endX = w;
        break;
      case ConnectorAnimation.growOut:
        final center = w / 2;
        final half = (w / 2) * progress;
        startX = center - half;
        endX = center + half;
        break;
      case ConnectorAnimation.wave:
      case ConnectorAnimation.pulse:
      case ConnectorAnimation.wipe:
      case ConnectorAnimation.ripple:
        startX = 0;
        endX = w;
        break;
    }

    if (animationStyle == ConnectorAnimation.wave) {
      paint.color = color;
      final waveCount = 3.0;
      final path = Path();
      path.moveTo(0, cy);
      for (double x = 0; x <= w; x += 2) {
        final waveOffset = sin((x / w * waveCount * pi * 2) + (progress * pi * 2)) * thickness * 1.5;
        path.lineTo(x, cy + waveOffset);
      }
      canvas.drawPath(path, paint);
      return;
    }

    if (animationStyle == ConnectorAnimation.pulse) {
      paint.color = color.withValues(alpha: pulseValue);
      canvas.drawLine(Offset(0, cy), Offset(w, cy), paint);
      return;
    }

    if (animationStyle == ConnectorAnimation.draw) {
      paint.color = color;
      final totalLength = w;
      final drawnLength = totalLength * progress;
      final dashLen = 6.0;
      final gapLen = 4.0;
      double x = 0;
      bool drawing = true;
      double drawn = 0;
      while (x < w && drawn < drawnLength) {
        final segmentLen = drawing ? dashLen : gapLen;
        final segEnd = (x + segmentLen).clamp(0, w);
        if (drawing) {
          final segDrawEnd = (drawn + (segEnd - x)).clamp(0, drawnLength);
          final drawEnd = x + (segDrawEnd - drawn);
          canvas.drawLine(Offset(x, cy), Offset(drawEnd, cy), paint);
          drawn += segEnd - x;
        }
        x = segEnd.toDouble();
        drawing = !drawing;
      }
      return;
    }

    if (animationStyle == ConnectorAnimation.stagger) {
      paint.color = color;
      final totalLength = w;
      final drawnLength = totalLength * progress;
      final segLen = 10.0;
      final gapLen = 6.0;
      double x = 0;
      double drawn = 0;
      while (x < w && drawn < drawnLength) {
        final seg = (x + segLen).clamp(0.0, w).toDouble();
        final segDrawn = drawn + (seg - x);
        if (segDrawn <= drawnLength) {
          canvas.drawLine(Offset(x, cy), Offset(seg, cy), paint);
        } else {
          final partial = drawnLength - drawn;
          canvas.drawLine(Offset(x, cy), Offset(x + partial, cy), paint);
        }
        drawn += seg - x;
        x = (seg + gapLen).clamp(0.0, w).toDouble();
        drawn += gapLen;
      }
      return;
    }

    if (animationStyle == ConnectorAnimation.wipe) {
      paint.color = color.withValues(alpha: 1.0);
      canvas.save();
      canvas.clipRect(Rect.fromLTWH(0, 0, w * progress, size.height));
      canvas.drawLine(Offset(0, cy), Offset(w, cy), paint);
      canvas.restore();
      return;
    }

    if (animationStyle == ConnectorAnimation.glow) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: 0.3 * progress)
        ..strokeWidth = thickness * 4
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawLine(Offset(0, cy), Offset(w * progress, cy), glowPaint);
      paint.color = color;
      canvas.drawLine(Offset(0, cy), Offset(w * progress, cy), paint);
      return;
    }

    if (animationStyle == ConnectorAnimation.ripple) {
      paint.color = color;
      canvas.drawLine(Offset(0, cy), Offset(w, cy), paint);
      final rippleX = w * progress;
      final ripplePaint = Paint()
        ..color = color.withValues(alpha: 0.6 * (1 - progress % 0.2).abs())
        ..strokeWidth = thickness * 2;
      canvas.drawCircle(Offset(rippleX, cy), thickness * 3, ripplePaint);
      return;
    }

    if (animationStyle == ConnectorAnimation.morph) {
      paint.color = color;
      final painted = startX + (endX - startX) * progress;
      if (progress < 0.5) {
        final dotSpacing = ((endX - startX) / dotCount).clamp(4.0, double.infinity).toDouble();
        for (double x = startX; x < startX + painted && x < endX; x += dotSpacing) {
          canvas.drawCircle(Offset(x, cy), thickness / 2, paint);
        }
      } else {
        canvas.drawLine(Offset(startX, cy), Offset(startX + painted, cy), paint);
      }
      return;
    }

    if (animationStyle == ConnectorAnimation.slideIn) {
      paint.color = color;
      final offset = thickness * 3 * (1 - progress);
      canvas.drawLine(Offset(startX - offset, cy), Offset(endX - offset, cy), paint);
      return;
    }

    if (startX >= endX) return;

    if (style == LineStyle.gradient && gradientStart != null && gradientEnd != null) {
      paint.shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [gradientStart!, gradientEnd!],
      ).createShader(Rect.fromLTWH(startX, 0, endX - startX, size.height));
      canvas.drawLine(Offset(startX, cy), Offset(endX, cy), paint);
    } else if (style == LineStyle.dotted) {
      paint.color = color;
      final dotSpacing = ((endX - startX) / dotCount).clamp(4.0, double.infinity).toDouble();
      for (double x = startX; x < endX; x += dotSpacing) {
        canvas.drawCircle(Offset(x, cy), thickness / 2, paint);
      }
    } else if (style == LineStyle.dashed) {
      paint.color = color;
      final dashLength = 8.0;
      final gapLength = 6.0;
      double x = startX;
      bool drawing = true;
      while (x < endX) {
        final segmentEnd = (x + (drawing ? dashLength : gapLength)).clamp(startX, endX).toDouble();
        if (drawing) {
          canvas.drawLine(Offset(x, cy), Offset(segmentEnd, cy), paint);
        }
        x = segmentEnd.toDouble();
        drawing = !drawing;
      }
    } else {
      paint.color = color;
      canvas.drawLine(Offset(startX, cy), Offset(endX, cy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.pulseValue != pulseValue ||
        oldDelegate.color != color ||
        oldDelegate.style != style ||
        oldDelegate.animationStyle != animationStyle ||
        oldDelegate.isHorizontal != isHorizontal;
  }
}