import 'package:flutter/material.dart';
import 'timeline_theme.dart';

class TimelineEvent {
  final String? title;
  final String? description;
  final String? date;
  final IconData? icon;
  final String? imageUrl;
  final Widget? imageWidget;
  final double? progressValue;
  final String? progressLabel;
  final Widget? customWidget;
  final Widget? expandedWidget;
  final int? number;
  final Color? indicatorColor;
  final Widget? indicator;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final TimelineThemeData? themeOverride;

  const TimelineEvent._({
    this.title,
    this.description,
    this.date,
    this.icon,
    this.imageUrl,
    this.imageWidget,
    this.progressValue,
    this.progressLabel,
    this.customWidget,
    this.expandedWidget,
    this.number,
    this.indicatorColor,
    this.indicator,
    this.height,
    this.margin,
    this.themeOverride,
  });

  factory TimelineEvent({
    String? title,
    String? description,
    String? date,
    IconData? icon,
    Widget? indicator,
    Color? indicatorColor,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      title: title,
      description: description,
      date: date,
      icon: icon,
      indicator: indicator,
      indicatorColor: indicatorColor,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.text({
    required String title,
    String? description,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      title: title,
      description: description,
      date: date,
      icon: icon,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.image({
    required String title,
    required String imageUrl,
    String? description,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      title: title,
      description: description,
      date: date,
      icon: icon,
      imageUrl: imageUrl,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.imageWidget({
    required String title,
    required Widget imageWidget,
    String? description,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      title: title,
      description: description,
      date: date,
      icon: icon,
      imageWidget: imageWidget,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.icon({
    required String title,
    required IconData icon,
    String? description,
    String? date,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      title: title,
      description: description,
      date: date,
      icon: icon,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.progress({
    required String label,
    required double value,
    String? title,
    String? description,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      title: title,
      description: description,
      date: date,
      icon: icon,
      progressLabel: label,
      progressValue: value.clamp(0.0, 1.0),
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.card({
    required Widget customWidget,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: customWidget,
      date: date,
      icon: icon,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.expandable({
    required String title,
    required Widget expandedWidget,
    String? description,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      title: title,
      description: description,
      date: date,
      icon: icon,
      expandedWidget: expandedWidget,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.custom({
    required Widget customWidget,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: customWidget,
      date: date,
      icon: icon,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.video({
    required String title,
    required String thumbnailUrl,
    String? description,
    String? duration,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: _VideoContent(
        title: title,
        thumbnailUrl: thumbnailUrl,
        description: description,
        duration: duration,
      ),
      title: title,
      description: description,
      date: date,
      icon: icon ?? Icons.play_circle,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.code({
    required String code,
    required String language,
    String? title,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: _CodeContent(code: code, language: language),
      title: title ?? language,
      date: date,
      icon: icon ?? Icons.code,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.quote({
    required String quote,
    required String author,
    String? authorTitle,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: _QuoteContent(quote: quote, author: author, authorTitle: authorTitle),
      date: date,
      icon: icon ?? Icons.format_quote,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.link({
    required String url,
    required String label,
    String? description,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: _LinkContent(url: url, label: label, description: description),
      date: date,
      icon: icon ?? Icons.link,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.tags({
    required List<String> tags,
    String? title,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: _TagsContent(tags: tags, title: title),
      title: title,
      date: date,
      icon: icon ?? Icons.label,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.stats({
    required Map<String, String> stats,
    String? title,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: _StatsContent(stats: stats, title: title),
      title: title,
      date: date,
      icon: icon ?? Icons.bar_chart,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }

  factory TimelineEvent.avatar({
    required String name,
    required String avatarUrl,
    String? subtitle,
    String? date,
    IconData? icon,
    Color? indicatorColor,
    Widget? indicator,
    int? number,
    double? height,
    EdgeInsetsGeometry? margin,
    TimelineThemeData? themeOverride,
  }) {
    return TimelineEvent._(
      customWidget: _AvatarContent(name: name, avatarUrl: avatarUrl, subtitle: subtitle),
      date: date,
      icon: icon ?? Icons.person,
      indicatorColor: indicatorColor,
      indicator: indicator,
      number: number,
      height: height,
      margin: margin,
      themeOverride: themeOverride,
    );
  }
}

class _VideoContent extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String? description;
  final String? duration;
  const _VideoContent({required this.title, required this.thumbnailUrl, this.description, this.duration});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(thumbnailUrl, height: 140, width: double.infinity, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(height: 140, color: Colors.grey.shade200, child: const Center(child: Icon(Icons.broken_image))),
              ),
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.6), shape: BoxShape.circle),
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
              ),
              if (duration != null)
                Positioned(right: 8, bottom: 8, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(4)),
                  child: Text(duration!, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
                )),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        if (description != null) const SizedBox(height: 4),
        if (description != null) Text(description!, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }
}

class _CodeContent extends StatelessWidget {
  final String code;
  final String language;
  const _CodeContent({required this.code, required this.language});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: Colors.red.shade400),
              const SizedBox(width: 6),
              Icon(Icons.circle, size: 10, color: Colors.amber.shade400),
              const SizedBox(width: 6),
              Icon(Icons.circle, size: 10, color: Colors.green.shade400),
              const SizedBox(width: 12),
              Text(language, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 10),
          Text(code, style: const TextStyle(color: Color(0xFFD4D4D4), fontSize: 12, fontFamily: 'monospace', height: 1.5)),
        ],
      ),
    );
  }
}

class _QuoteContent extends StatelessWidget {
  final String quote;
  final String author;
  final String? authorTitle;
  const _QuoteContent({required this.quote, required this.author, this.authorTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.format_quote, size: 28, color: Colors.grey.shade400),
          const SizedBox(height: 4),
          Text(quote, style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey.shade800, height: 1.4)),
          const SizedBox(height: 10),
          Text(author, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          if (authorTitle != null) Text(authorTitle!, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}

class _LinkContent extends StatelessWidget {
  final String url;
  final String label;
  final String? description;
  const _LinkContent({required this.url, required this.label, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.link, color: Colors.blue.shade600, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.blue.shade800)),
                if (description != null) Text(description!, style: TextStyle(fontSize: 11, color: Colors.blue.shade600)),
                const SizedBox(height: 4),
                Text(url, style: TextStyle(fontSize: 11, color: Colors.grey.shade500), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TagsContent extends StatelessWidget {
  final List<String> tags;
  final String? title;
  const _TagsContent({required this.tags, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(title!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
        ],
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: tags.map((t) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(t, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          )).toList(),
        ),
      ],
    );
  }
}

class _StatsContent extends StatelessWidget {
  final Map<String, String> stats;
  final String? title;
  const _StatsContent({required this.stats, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(title!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
        ],
        Row(
          children: stats.entries.map((e) => Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(e.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(e.key, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                ],
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}

class _AvatarContent extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final String? subtitle;
  const _AvatarContent({required this.name, required this.avatarUrl, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(avatarUrl),
          onBackgroundImageError: (_, __) {},
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              if (subtitle != null) const SizedBox(height: 2),
              if (subtitle != null) Text(subtitle!, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    );
  }
}
