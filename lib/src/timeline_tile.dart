import 'dart:math' show max;
import 'package:flutter/material.dart';
import 'timeline_theme.dart';
import 'content_builders.dart';
import 'timeline_indicator.dart';
import 'timeline_connector.dart';
import 'responsive.dart';

class TimelineTileWidget extends StatefulWidget {
  final TimelineEvent event;
  final TimelineThemeData theme;
  final int index;
  final bool isLast;
  final TimelineAxis axis;
  final double? itemWidth;
  final bool reverse;

  const TimelineTileWidget({
    super.key,
    required this.event,
    required this.theme,
    required this.index,
    this.isLast = false,
    this.axis = TimelineAxis.vertical,
    this.itemWidth,
    this.reverse = false,
  });

  @override
  State<TimelineTileWidget> createState() => _TimelineTileWidgetState();
}

class _TimelineTileWidgetState extends State<TimelineTileWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final event = widget.event;

    final content = _buildContent(theme, event);
    final contentWidget = event.customWidget ?? content;

    final indicator = TimelineIndicator(
      theme: theme,
      icon: event.icon,
      color: event.indicatorColor,
      customWidget: event.indicator,
      number: event.number,
    );

    if (widget.axis == TimelineAxis.horizontal) {
      return _buildHorizontalTile(context, theme, indicator, contentWidget);
    }
    return _buildVerticalTile(context, theme, indicator, contentWidget);
  }

  Widget _buildVerticalTile(
    BuildContext context,
    TimelineThemeData theme,
    Widget indicator,
    Widget contentWidget,
  ) {
    final eventMargin = widget.event.margin ?? EdgeInsets.only(bottom: theme.spacingBetweenEvents);

    return Container(
      margin: eventMargin,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(left: theme.indicatorSize + 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 4 + theme.indicatorSize),
              child: contentWidget,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: theme.indicatorSize + 16,
              child: Column(
                children: [
                  SizedBox(height: 4),
                  indicator,
                  Flexible(
                    fit: FlexFit.loose,
                    child: TimelineConnector(
                      theme: theme,
                      isLast: widget.isLast,
                      index: widget.index,
                      reverse: widget.reverse,
                      axis: TimelineAxis.vertical,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalTile(
    BuildContext context,
    TimelineThemeData theme,
    Widget indicator,
    Widget contentWidget,
  ) {
    final itemW = widget.itemWidth ?? timelineItemWidth(context);
    final alignTop = widget.index.isEven;
    final trackHeight = max(theme.indicatorSize + 8, theme.lineWidth + 16);

    return SizedBox(
      width: itemW,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (alignTop) Flexible(child: contentWidget),
          SizedBox(
            height: trackHeight,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: max(theme.lineWidth, 2.0),
                    child: TimelineConnector(
                      theme: theme,
                      isLast: widget.isLast,
                      index: widget.index,
                      reverse: widget.reverse,
                      axis: TimelineAxis.horizontal,
                    ),
                  ),
                ),
                indicator,
              ],
            ),
          ),
          if (!alignTop) Flexible(child: contentWidget),
        ],
      ),
    );
  }

  Widget _buildContent(TimelineThemeData theme, TimelineEvent event) {
    if (event.customWidget != null) {
      return _buildCard(theme, event.customWidget!);
    }

    final hasProgress = event.progressValue != null;
    final hasExpanded = event.expandedWidget != null;

    return _buildCard(
      theme,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (event.date != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(event.date!, style: theme.dateStyle),
            ),
          if (event.title != null)
            Padding(
              padding: EdgeInsets.only(bottom: event.description != null ? 8 : 0),
              child: Text(event.title!, style: theme.titleStyle),
            ),
          if (event.imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    event.imageUrl!,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  errorBuilder: (_, __, ___) => Container(
                    height: 100,
                    color: Colors.grey.shade200,
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ),
          if (event.imageWidget != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: event.imageWidget,
              ),
            ),
          if (event.description != null)
            Text(event.description!, style: theme.descriptionStyle),
          if (hasProgress) ...[
            const SizedBox(height: 8),
            _buildProgressBar(theme, event),
          ],
          if (hasExpanded) ...[
            const SizedBox(height: 8),
            _buildExpandButton(theme, event),
          ],
        ],
      ),
    );
  }

  Widget _buildCard(TimelineThemeData theme, Widget child) {
    final card = Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: theme.cardBackground ?? Colors.white,
        borderRadius: theme.cardBorderRadius,
        boxShadow: theme.cardElevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08 * theme.cardElevation),
                  blurRadius: 8 * theme.cardElevation,
                  offset: Offset(0, 2 * theme.cardElevation),
                ),
              ]
            : null,
      ),
      padding: theme.cardPadding,
      child: child,
    );

    if (theme.effect == TimelineEffect.shimmer) {
      return _ShimmerWrapper(child: card);
    }

    return card;
  }

  Widget _buildProgressBar(TimelineThemeData theme, TimelineEvent event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (event.progressLabel != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              event.progressLabel!,
              style: theme.descriptionStyle?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: event.progressValue,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.indicatorColor ?? Colors.blue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandButton(TimelineThemeData theme, TimelineEvent event) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Row(
            children: [
              Text(
                _isExpanded ? 'Less' : 'More',
                style: TextStyle(
                  color: theme.indicatorColor ?? Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: theme.indicatorColor ?? Colors.blue,
                size: 20,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: event.expandedWidget!,
          ),
          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

}

class _ShimmerWrapper extends StatefulWidget {
  final Widget child;
  const _ShimmerWrapper({required this.child});

  @override
  State<_ShimmerWrapper> createState() => _ShimmerWrapperState();
}

class _ShimmerWrapperState extends State<_ShimmerWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.4),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
