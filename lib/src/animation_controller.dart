import 'package:flutter/material.dart';

class TimelineAnimationController {
  final AnimationController controller;

  TimelineAnimationController({
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 1200),
  }) : controller = AnimationController(
         vsync: vsync,
         duration: duration,
       );

  void forward() => controller.forward();
  void reverse() => controller.reverse();
  void play() {
    if (controller.isCompleted) {
      controller.reset();
    }
    controller.forward();
  }
  void pause() => controller.stop();
  void reset() => controller.reset();
  void seek(double value) => controller.value = value.clamp(0.0, 1.0);
  void repeat({Duration? period}) => controller.repeat(period: period);
  bool get isAnimating => controller.isAnimating;
  double get value => controller.value;
  Duration get duration => controller.duration!;

  void dispose() => controller.dispose();
}

class TimelineAnimationScope extends InheritedWidget {
  final TimelineAnimationController? controller;

  const TimelineAnimationScope({
    super.key,
    required this.controller,
    required super.child,
  });

  static TimelineAnimationController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TimelineAnimationScope>()?.controller;
  }

  @override
  bool updateShouldNotify(TimelineAnimationScope oldWidget) => controller != oldWidget.controller;
}
