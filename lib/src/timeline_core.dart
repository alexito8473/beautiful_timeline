import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'timeline_theme.dart';
import 'timeline_themes.dart';
import 'content_builders.dart';
import 'timeline_tile.dart';
import 'animations.dart';
import 'animation_controller.dart';
import 'responsive.dart';

class BeautifulTimeline extends StatefulWidget {
  final List<TimelineEvent> events;
  final TimelineThemeData? theme;
  final TimelineAxis axis;
  final bool showAnimation;
  final double? itemWidth;
  final TimelineBreakpoint? breakpoints;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final TimelineAnimationController? animationController;
  final bool reverse;

  const BeautifulTimeline({
    super.key,
    required this.events,
    this.theme,
    this.axis = TimelineAxis.responsive,
    this.showAnimation = true,
    this.itemWidth,
    this.breakpoints,
    this.physics,
    this.scrollController,
    this.animationController,
    this.reverse = false,
  });

  const BeautifulTimeline.builder({
    super.key,
    required this.events,
    this.theme,
    this.axis = TimelineAxis.responsive,
    this.showAnimation = true,
    this.itemWidth,
    this.breakpoints,
    this.physics,
    this.scrollController,
    this.animationController,
    this.reverse = false,
  });

  @override
  State<BeautifulTimeline> createState() => _BeautifulTimelineState();
}

class _BeautifulTimelineState extends State<BeautifulTimeline>
    with SingleTickerProviderStateMixin {
  TimelineAnimationController? _internalController;
  ScrollController? _horizontalScrollController;

  TimelineAnimationController get _controller =>
      widget.animationController ?? _internalController!;

  ScrollController get _effectiveHorizontalController =>
      widget.scrollController ?? (_horizontalScrollController ??= ScrollController());

  bool _didAutoPlay = false;

  @override
  void initState() {
    super.initState();
    if (widget.animationController == null && widget.showAnimation) {
      _internalController = TimelineAnimationController(vsync: this);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didAutoPlay && widget.showAnimation && mounted) {
      _didAutoPlay = true;
      if (_internalController != null) {
        _internalController!.forward();
      }
    }
  }

  @override
  void dispose() {
    _horizontalScrollController?.dispose();
    _internalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = _resolveTheme();
    final effectiveAxis = widget.axis == TimelineAxis.responsive
        ? resolveAxis(context, breakpoints: widget.breakpoints)
        : widget.axis;

    final timeline = Container(
      color: effectiveTheme.backgroundColor ??
          effectiveTheme.timelineBackground ??
          Colors.transparent,
      child: effectiveAxis == TimelineAxis.horizontal
          ? _buildHorizontalTimeline(context, effectiveTheme)
          : _buildVerticalTimeline(context, effectiveTheme, effectiveAxis),
    );

    if (!widget.showAnimation) return timeline;

    return TimelineAnimationScope(
      controller: widget.showAnimation ? _controller : null,
      child: timeline,
    );
  }

  TimelineThemeData _resolveTheme() => widget.theme ?? TimelineThemes.modern();

  Widget _buildVerticalTimeline(
    BuildContext context,
    TimelineThemeData effectiveTheme,
    TimelineAxis effectiveAxis,
  ) {
    final events = widget.reverse ? widget.events.reversed.toList() : widget.events;
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: widget.physics,
      reverse: widget.reverse,
      padding: effectiveTheme.padding,
      child: Column(
        verticalDirection: widget.reverse ? VerticalDirection.up : VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(events.length, (index) {
          final event = events[index];
          final tileTheme = event.themeOverride != null
              ? effectiveTheme.copyWith(
                  lineColor: event.themeOverride!.lineColor,
                  lineWidth: event.themeOverride!.lineWidth,
                  lineStyle: event.themeOverride!.lineStyle,
                  indicatorColor: event.themeOverride!.indicatorColor,
                  indicatorSize: event.themeOverride!.indicatorSize,
                  cardBackground: event.themeOverride!.cardBackground,
                  cardElevation: event.themeOverride!.cardElevation,
                  cardPadding: event.themeOverride!.cardPadding,
                  cardBorderRadius: event.themeOverride!.cardBorderRadius,
                  connectorAnimation: event.themeOverride!.connectorAnimation,
                )
              : effectiveTheme;
          final tile = TimelineTileWidget(
            event: event,
            theme: tileTheme,
            index: index,
            isLast: index == events.length - 1,
            axis: effectiveAxis,
            reverse: widget.reverse,
          );

          if (widget.showAnimation) {
            return animateEntry(
              tile,
              index,
              duration: effectiveTheme.animationDuration,
              curve: effectiveTheme.animationCurve,
            );
          }
          return tile;
        }),
      ),
    );
  }

  Widget _buildHorizontalTimeline(
    BuildContext context,
    TimelineThemeData effectiveTheme,
  ) {
    final events = widget.reverse ? widget.events.reversed.toList() : widget.events;
    final controller = _effectiveHorizontalController;
    final currentBehavior = ScrollConfiguration.of(context);
    final behavior = currentBehavior.copyWith(
      dragDevices: <PointerDeviceKind>{
        ...currentBehavior.dragDevices,
        PointerDeviceKind.mouse,
      },
    );
    return ScrollConfiguration(
      behavior: behavior,
      child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent && controller.hasClients) {
            final delta = event.scrollDelta.dy != 0 ? event.scrollDelta.dy : event.scrollDelta.dx;
            if (delta != 0) {
              controller.position.pointerScroll(delta);
            }
          }
        },
        child: SingleChildScrollView(
          controller: controller,
          physics: widget.physics,
          scrollDirection: Axis.horizontal,
          padding: effectiveTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(events.length, (index) {
            final event = events[index];
            final tileTheme = event.themeOverride != null
                ? effectiveTheme.copyWith(
                    lineColor: event.themeOverride!.lineColor,
                    lineWidth: event.themeOverride!.lineWidth,
                    lineStyle: event.themeOverride!.lineStyle,
                    indicatorColor: event.themeOverride!.indicatorColor,
                    indicatorSize: event.themeOverride!.indicatorSize,
                    cardBackground: event.themeOverride!.cardBackground,
                    cardElevation: event.themeOverride!.cardElevation,
                    cardPadding: event.themeOverride!.cardPadding,
                    cardBorderRadius: event.themeOverride!.cardBorderRadius,
                    connectorAnimation: event.themeOverride!.connectorAnimation,
                  )
                : effectiveTheme;
            final tile = TimelineTileWidget(
              event: event,
              theme: tileTheme,
              index: index,
              isLast: index == events.length - 1,
              axis: TimelineAxis.horizontal,
              itemWidth: widget.itemWidth,
              reverse: widget.reverse,
            );

            if (widget.showAnimation) {
              return animateEntry(
                tile,
                index,
                duration: effectiveTheme.animationDuration,
                curve: effectiveTheme.animationCurve,
              );
            }
            return tile;
          }),
        ),
      ),
      ),
    );
  }
}
