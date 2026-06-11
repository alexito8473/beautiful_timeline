import 'package:flutter/material.dart';
import 'timeline_theme.dart';

class TimelineBreakpoint {
  final double mobile;
  final double tablet;

  const TimelineBreakpoint({
    this.mobile = 600,
    this.tablet = 900,
  });
}

TimelineAxis resolveAxis(BuildContext context, {TimelineBreakpoint? breakpoints}) {
  final b = breakpoints ?? const TimelineBreakpoint();
  final width = MediaQuery.of(context).size.width;
  if (width < b.tablet) return TimelineAxis.vertical;
  return TimelineAxis.horizontal;
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 600;
}

bool isTablet(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  return w >= 600 && w < 900;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= 900;
}

double timelineItemWidth(BuildContext context, {double? fixedWidth}) {
  if (fixedWidth != null) return fixedWidth;
  final w = MediaQuery.of(context).size.width;
  if (w >= 900) return 280;
  if (w >= 600) return 240;
  return double.infinity;
}
