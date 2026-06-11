import 'package:flutter/material.dart';
import 'package:beautiful_timeline/beautiful_timeline.dart';

void main() {
  runApp(const TimelineDemoApp());
}

class TimelineDemoApp extends StatelessWidget {
  const TimelineDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful Timeline Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatefulWidget {
  const DemoHome({super.key});

  @override
  State<DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beautiful Timeline'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const ThemesAndAnimationTab(),
          const EventTypesTab(),
          const NewContentTab(),
          const CustomTimelineTab(),
          const IndicatorsTab(),
          const CustomizerTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (i) => setState(() => _selectedTab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.palette_outlined),
            selectedIcon: Icon(Icons.palette),
            label: 'Themes',
          ),
          NavigationDestination(
            icon: Icon(Icons.widgets_outlined),
            selectedIcon: Icon(Icons.widgets),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.rocket_launch_outlined),
            selectedIcon: Icon(Icons.rocket_launch),
            label: 'Content',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune),
            label: 'Lines',
          ),
          NavigationDestination(
            icon: Icon(Icons.lens_outlined),
            selectedIcon: Icon(Icons.lens),
            label: 'Indicators',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Customize',
          ),
        ],
      ),
    );
  }
}

class ThemesAndAnimationTab extends StatefulWidget {
  const ThemesAndAnimationTab({super.key});

  @override
  State<ThemesAndAnimationTab> createState() => _ThemesAndAnimationTabState();
}

class _ThemesAndAnimationTabState extends State<ThemesAndAnimationTab>
    with SingleTickerProviderStateMixin {
  int _selectedTheme = 0;
  ConnectorAnimation _selectedAnimation = ConnectorAnimation.growDown;
  TimelineAxis _axis = TimelineAxis.responsive;
  late TimelineAnimationController _animController;

  final _themes = <String, TimelineThemeData Function()>{
    'Minimal': TimelineThemes.minimal,
    'Modern': TimelineThemes.modern,
    'Gradient': TimelineThemes.gradient,
    'Card': TimelineThemes.card,
    'Cupertino': TimelineThemes.cupertino,
    'Material': TimelineThemes.material,
    'Dark': TimelineThemes.dark,
    'Neumorphic': TimelineThemes.neumorphic,
    'Dotted': TimelineThemes.dotted,
    'Bubble': TimelineThemes.bubble,
    'Sunset': TimelineThemes.sunset,
    'Ocean': TimelineThemes.ocean,
    'Forest': TimelineThemes.forest,
    'Galaxy': TimelineThemes.galaxy,
    'Retro': TimelineThemes.retro,
    'Neon': TimelineThemes.neon,
    'Pastel': TimelineThemes.pastel,
    'Luxury': TimelineThemes.luxury,
    'Cyberpunk': TimelineThemes.cyberpunk,
    'Coffee': TimelineThemes.coffee,
  };

  final _animations = const <String, ConnectorAnimation>{
    'Grow Down': ConnectorAnimation.growDown,
    'Grow Up': ConnectorAnimation.growUp,
    'Grow Out': ConnectorAnimation.growOut,
    'Wave': ConnectorAnimation.wave,
    'Pulse': ConnectorAnimation.pulse,
    'Draw': ConnectorAnimation.draw,
    'Fade In': ConnectorAnimation.fadeIn,
    'Bounce': ConnectorAnimation.bounce,
  };

  late final List<TimelineEvent> _events;

  @override
  void initState() {
    super.initState();
    _animController = TimelineAnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animController.repeat();
    _events = [
      TimelineEvent.icon(
        title: 'Project Started',
        description: 'Initial planning and team setup.',
        date: 'Jan 2026',
        icon: Icons.rocket_launch,
      ),
      TimelineEvent.image(
        title: 'Design Phase',
        description: 'UI/UX design completed with user testing feedback.',
        date: 'Feb 2026',
        imageUrl: 'https://picsum.photos/seed/design/400/200',
        icon: Icons.design_services,
      ),
      TimelineEvent.progress(
        title: 'Development Sprint 1',
        description: 'Core architecture implemented with testing framework.',
        label: 'Progress',
        value: 0.75,
        date: 'Mar 2026',
        icon: Icons.code,
      ),
      TimelineEvent.icon(
        title: 'Beta Release',
        description: 'First beta released to internal testers.',
        date: 'Apr 2026',
        icon: Icons.bug_report,
      ),
      TimelineEvent.expandable(
        title: 'User Testing Results',
        description: 'Tap to see detailed metrics.',
        date: 'May 2026',
        icon: Icons.analytics,
        expandedWidget: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _metricRow('Satisfaction', '4.8 / 5.0'),
              _metricRow('Crash Rate', '0.2%'),
              _metricRow('Retention', '94%'),
            ],
          ),
        ),
      ),
      TimelineEvent.icon(
        title: 'Production Launch',
        description: 'App launched successfully.',
        date: 'Jun 2026',
        icon: Icons.celebration,
      ),
    ];
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Widget _metricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNames = _themes.keys.toList();
    final currentTheme = _themes.values.toList()[_selectedTheme]();
    final effectiveTheme = currentTheme.copyWith(
      connectorAnimation: _selectedAnimation,
    );

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: effectiveTheme.backgroundColor ?? Colors.grey.shade100,
          child: Text(
            '${themeNames[_selectedTheme]} \u2022 ${_animations.keys.elementAt(_animations.values.toList().indexOf(_selectedAnimation))}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: effectiveTheme.indicatorColor ?? Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              ...List.generate(themeNames.length, (i) {
                final selected = i == _selectedTheme;
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: ChoiceChip(
                    label: Text(themeNames[i], style: const TextStyle(fontSize: 11)),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedTheme = i),
                    visualDensity: VisualDensity.compact,
                  ),
                );
              }),
            ],
          ),
        ),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              ..._animations.entries.map((e) {
                final selected = e.value == _selectedAnimation;
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: ChoiceChip(
                    label: Text(e.key, style: const TextStyle(fontSize: 11)),
                    selected: selected,
                    selectedColor: effectiveTheme.indicatorColor?.withValues(alpha: 0.2),
                    onSelected: (_) => setState(() => _selectedAnimation = e.value),
                    visualDensity: VisualDensity.compact,
                  ),
                );
              }),
            ],
          ),
        ),
        SizedBox(
          height: 32,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              for (final axis in TimelineAxis.values)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: ChoiceChip(
                    label: Text(axis.name, style: const TextStyle(fontSize: 11)),
                    selected: _axis == axis,
                    onSelected: (_) => setState(() => _axis = axis),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              _smallBtn(Icons.play_arrow, () => _animController.play()),
              const SizedBox(width: 4),
              _smallBtn(Icons.pause, () => _animController.pause()),
              const SizedBox(width: 4),
              _smallBtn(Icons.replay, () => _animController.reset()),
              const SizedBox(width: 4),
              _smallBtn(Icons.replay_10, () => _animController.reverse()),
              const SizedBox(width: 12),
              Expanded(
                child: Slider(
                  value: _animController.value,
                  onChanged: (v) => _animController.seek(v),
                  min: 0,
                  max: 1,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BeautifulTimeline(
            axis: _axis,
            theme: effectiveTheme,
            events: _events,
            showAnimation: true,
            animationController: _animController,
          ),
        ),
      ],
    );
  }

  Widget _smallBtn(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

class EventTypesTab extends StatelessWidget {
  const EventTypesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TimelineThemes.modern().copyWith(
      connectorAnimation: ConnectorAnimation.growDown,
    );

    final events = [
      TimelineEvent.text(
        title: 'Text Event',
        description: 'Simple text with title, description and date.',
        date: 'Simple',
      ),
      TimelineEvent.icon(
        title: 'Icon Event',
        description: 'Event with a custom icon as indicator.',
        date: 'Icon',
        icon: Icons.star,
      ),
      TimelineEvent.image(
        title: 'Image Event',
        description: 'Network image loaded from a URL.',
        date: 'Image',
        imageUrl: 'https://picsum.photos/seed/example/400/200',
        icon: Icons.image,
      ),
      TimelineEvent.imageWidget(
        title: 'ImageWidget Event',
        description: 'Custom widget used as the image.',
        date: 'Widget',
        imageWidget: Container(
          height: 80,
          color: Colors.blue.shade50,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flutter_dash, size: 32, color: Colors.blue.shade400),
                const SizedBox(width: 6),
                Text('Flutter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue.shade400)),
              ],
            ),
          ),
        ),
        icon: Icons.widgets,
      ),
      TimelineEvent.progress(
        title: 'Progress Event',
        description: 'Shows a progress bar for tracking completion.',
        label: 'Completion',
        value: 0.65,
        date: '65%',
        icon: Icons.pie_chart,
      ),
      TimelineEvent.card(
        date: 'Card',
        customWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Card Event', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade800)),
              const SizedBox(height: 4),
              Text('Custom card widget inside the timeline card.', style: TextStyle(color: Colors.amber.shade700, fontSize: 13)),
            ],
          ),
        ),
        icon: Icons.credit_card,
      ),
      TimelineEvent.expandable(
        title: 'Expandable Event',
        description: 'Tap "More" to reveal hidden content.',
        date: 'Expand',
        icon: Icons.expand,
        expandedWidget: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hidden details:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade700)),
              const SizedBox(height: 6),
              Text('Line item 1', style: TextStyle(color: Colors.indigo.shade600)),
              Text('Line item 2', style: TextStyle(color: Colors.indigo.shade600)),
            ],
          ),
        ),
      ),
      TimelineEvent.custom(
        date: 'Custom',
        customWidget: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade100, Colors.pink.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.purple.shade600, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Fully custom widget replacing the card content entirely.',
                  style: TextStyle(color: Colors.purple.shade800, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        icon: Icons.tune,
      ),
    ];

    return BeautifulTimeline(
      theme: theme,
      events: events,
      showAnimation: true,
    );
  }
}

class NewContentTab extends StatelessWidget {
  const NewContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TimelineThemes.modern().copyWith(
      connectorAnimation: ConnectorAnimation.growDown,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('VIDEO'),
          _sectionSubtitle('TimelineEvent.video with thumbnail, play button and duration.'),
          SizedBox(
            height: 280,
            child: BeautifulTimeline(
              physics: const NeverScrollableScrollPhysics(),
              theme: theme,
              events: [
                TimelineEvent.video(
                  title: 'Flutter Tutorial',
                  description: 'Learn Flutter in 10 minutes.',
                  thumbnailUrl: 'https://picsum.photos/seed/flutter/400/200',
                  duration: '10:32',
                  date: 'tutorial',
                ),
                TimelineEvent.video(
                  title: 'Code Review Session',
                  description: 'Reviewing the new architecture.',
                  thumbnailUrl: 'https://picsum.photos/seed/code/400/200',
                  duration: '24:15',
                  date: 'review',
                ),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('CODE SNIPPETS'),
          _sectionSubtitle('TimelineEvent.code with syntax-highlighted block.'),
          SizedBox(
            height: 320,
            child: BeautifulTimeline(
              physics: const NeverScrollableScrollPhysics(),
              theme: theme,
              events: [
                TimelineEvent.code(
                  title: 'Dart Function',
                  code: 'void main() {\n  print("Hello Timeline!");\n}',
                  language: 'Dart',
                  date: 'dart',
                ),
                TimelineEvent.code(
                  code: 'BeautifulTimeline(\n  theme: myTheme,\n  events: myEvents,\n)',
                  language: 'Flutter',
                  date: 'flutter',
                ),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('QUOTE / TESTIMONIAL'),
          _sectionSubtitle('TimelineEvent.quote with author attribution.'),
          SizedBox(
            height: 280,
            child: BeautifulTimeline(
              physics: const NeverScrollableScrollPhysics(),
              theme: theme,
              events: [
                TimelineEvent.quote(
                  quote: 'The best way to predict the future is to create it.',
                  author: 'Peter Drucker',
                  authorTitle: 'Management Consultant',
                  date: 'quote',
                ),
                TimelineEvent.quote(
                  quote: 'Simplicity is the soul of efficiency.',
                  author: 'Austin Freeman',
                  date: 'wisdom',
                ),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('LINK PREVIEW'),
          _sectionSubtitle('TimelineEvent.link with URL and description.'),
          SizedBox(
            height: 240,
            child: BeautifulTimeline(
              physics: const NeverScrollableScrollPhysics(),
              theme: theme,
              events: [
                TimelineEvent.link(
                  label: 'Flutter Documentation',
                  url: 'https://flutter.dev/docs',
                  description: 'Official Flutter docs and guides.',
                  date: 'link',
                ),
                TimelineEvent.link(
                  label: 'Beautiful Timeline',
                  url: 'https://pub.dev/packages/beautiful_timeline',
                  date: 'package',
                ),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('TAGS / CHIPS'),
          _sectionSubtitle('TimelineEvent.tags with chip labels.'),
          SizedBox(
            height: 200,
            child: BeautifulTimeline(
              physics: const NeverScrollableScrollPhysics(),
              theme: theme,
              events: [
                TimelineEvent.tags(
                  title: 'Technologies',
                  tags: ['Flutter', 'Dart', 'Firebase', 'REST API', 'SQLite'],
                  date: 'tags',
                ),
                TimelineEvent.tags(
                  tags: ['urgent', 'frontend', 'bugfix'],
                  date: 'labels',
                ),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('STATISTICS'),
          _sectionSubtitle('TimelineEvent.stats with key-value metrics.'),
          SizedBox(
            height: 220,
            child: BeautifulTimeline(
              physics: const NeverScrollableScrollPhysics(),
              theme: theme,
              events: [
                TimelineEvent.stats(
                  title: 'Performance',
                  stats: {'Users': '12K', 'Rating': '4.8', 'Uptime': '99.9%'},
                  date: 'stats',
                ),
                TimelineEvent.stats(
                  stats: {'Commits': '342', 'PRs': '28', 'Issues': '12'},
                  date: 'dev',
                ),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('AVATAR / USER'),
          _sectionSubtitle('TimelineEvent.avatar with profile picture and name.'),
          SizedBox(
            height: 220,
            child: BeautifulTimeline(
              physics: const NeverScrollableScrollPhysics(),
              theme: theme,
              events: [
                TimelineEvent.avatar(
                  name: 'Alice Johnson',
                  avatarUrl: 'https://i.pravatar.cc/64?img=1',
                  subtitle: 'Lead Developer',
                  date: 'avatar',
                ),
                TimelineEvent.avatar(
                  name: 'Bob Smith',
                  avatarUrl: 'https://i.pravatar.cc/64?img=2',
                  subtitle: 'UI/UX Designer',
                  date: 'designer',
                ),
              ],
              showAnimation: true,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue.shade700, letterSpacing: 1),
      ),
    );
  }

  Widget _sectionSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
    );
  }
}

class CustomTimelineTab extends StatefulWidget {
  const CustomTimelineTab({super.key});

  @override
  State<CustomTimelineTab> createState() => _CustomTimelineTabState();
}

class _CustomTimelineTabState extends State<CustomTimelineTab>
    with SingleTickerProviderStateMixin {
  late TimelineAnimationController _ctrl;
  bool _reverse = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TimelineAnimationController(vsync: this, duration: const Duration(seconds: 4));
    _ctrl.repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text('Reverse order', style: TextStyle(fontSize: 13)),
                const SizedBox(width: 8),
                Switch(
                  value: _reverse,
                  onChanged: (v) => setState(() => _reverse = v),
                ),
              ],
            ),
          ),
          _sectionHeader('LINE STYLES'),
          _sectionSubtitle('Solid, dotted, dashed and gradient lines with growDown animation.'),
          SizedBox(
            height: 280,
            child: BeautifulTimeline(
              reverse: _reverse,
              physics: const NeverScrollableScrollPhysics(),
              theme: TimelineThemeData(
                lineColor: Colors.blue.shade400,
                lineWidth: 3,
                connectorAnimation: ConnectorAnimation.growDown,
                indicatorStyle: IndicatorStyle.circle,
                indicatorColor: Colors.blue,
                indicatorSize: 26,
                spacingBetweenEvents: 8,
                cardBackground: Colors.white,
                cardElevation: 1,
                cardPadding: const EdgeInsets.all(12),
                cardBorderRadius: BorderRadius.circular(8),
                titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                descriptionStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              events: [
                TimelineEvent.icon(title: 'Solid Line', description: 'Default solid connector line.', date: 'solid', icon: Icons.horizontal_rule),
                TimelineEvent.icon(title: 'Dotted Line', description: 'Dotted connector line style.', date: 'dotted', icon: Icons.more_horiz, themeOverride: const TimelineThemeData(lineStyle: LineStyle.dotted)),
                TimelineEvent.icon(title: 'Dashed Line', description: 'Dashed connector line style.', date: 'dashed', icon: Icons.padding, themeOverride: const TimelineThemeData(lineStyle: LineStyle.dashed)),
                TimelineEvent.icon(title: 'Gradient Line', description: 'Purple-to-blue gradient line.', date: 'gradient', icon: Icons.gradient, themeOverride: const TimelineThemeData(lineStyle: LineStyle.gradient, lineGradientStart: Colors.purple, lineGradientEnd: Colors.blue)),
              ],
              showAnimation: true,
              animationController: _ctrl,
            ),
          ),
          _sectionHeader('ANIMATION STYLES'),
          _sectionSubtitle('6 connector animation styles with a shared controller. Use the buttons below.'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _fab(Icons.play_arrow, () => _ctrl.play()),
                const SizedBox(width: 8),
                _fab(Icons.pause, () => _ctrl.pause()),
                const SizedBox(width: 8),
                _fab(Icons.replay, () => _ctrl.reset()),
                const SizedBox(width: 8),
                _fab(Icons.replay_10, () => _ctrl.reverse()),
                const SizedBox(width: 12),
                Expanded(
                  child: Slider(
                    value: _ctrl.value,
                    onChanged: (v) => _ctrl.seek(v),
                    min: 0,
                    max: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            child: BeautifulTimeline(
              reverse: _reverse,
              physics: const NeverScrollableScrollPhysics(),
              theme: TimelineThemeData(
                lineColor: Colors.teal,
                lineWidth: 3,
                connectorAnimation: ConnectorAnimation.growDown,
                indicatorStyle: IndicatorStyle.circle,
                indicatorColor: Colors.teal,
                indicatorSize: 26,
                spacingBetweenEvents: 4,
                cardBackground: Colors.white,
                cardElevation: 1,
                cardPadding: const EdgeInsets.all(10),
                cardBorderRadius: BorderRadius.circular(8),
                titleStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                descriptionStyle: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              events: [
                TimelineEvent.icon(title: 'Grow Down', description: 'Line grows from top to bottom.', date: 'down', icon: Icons.arrow_downward),
                TimelineEvent.icon(title: 'Grow Up', description: 'Line grows from bottom up.', date: 'up', icon: Icons.arrow_upward, themeOverride: const TimelineThemeData(connectorAnimation: ConnectorAnimation.growUp)),
                TimelineEvent.icon(title: 'Grow Out', description: 'Line expands from center.', date: 'out', icon: Icons.unfold_more, themeOverride: const TimelineThemeData(connectorAnimation: ConnectorAnimation.growOut)),
                TimelineEvent.icon(title: 'Wave', description: 'Sine wave travels down.', date: 'wave', icon: Icons.waves, themeOverride: const TimelineThemeData(connectorAnimation: ConnectorAnimation.wave)),
                TimelineEvent.icon(title: 'Pulse', description: 'Line pulses in opacity.', date: 'pulse', icon: Icons.blur_on, themeOverride: const TimelineThemeData(connectorAnimation: ConnectorAnimation.pulse)),
                TimelineEvent.icon(title: 'Draw', description: 'Line draws like a pen stroke.', date: 'draw', icon: Icons.edit, themeOverride: const TimelineThemeData(connectorAnimation: ConnectorAnimation.draw)),
              ],
              showAnimation: true,
              animationController: _ctrl,
            ),
          ),
          _sectionHeader('PER-EVENT THEME OVERRIDES'),
          _sectionSubtitle('Each event can override lineColor, indicatorColor, indicatorSize, cardBackground, connectorAnimation and more via themeOverride. The parent theme is grey, then each event overrides its own look.'),
          SizedBox(
            height: 340,
            child: BeautifulTimeline(
              reverse: _reverse,
              physics: const NeverScrollableScrollPhysics(),
              theme: TimelineThemeData(
                lineColor: Colors.grey.shade300,
                lineWidth: 2,
                connectorAnimation: ConnectorAnimation.growDown,
                indicatorStyle: IndicatorStyle.circle,
                indicatorColor: Colors.grey,
                indicatorSize: 22,
                cardBackground: Colors.white,
                cardElevation: 0,
                cardPadding: const EdgeInsets.all(12),
                cardBorderRadius: BorderRadius.circular(8),
                titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                dateStyle: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                descriptionStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                spacingBetweenEvents: 8,
              ),
              events: [
                TimelineEvent.icon(title: 'Default', description: 'Grey theme default.', date: 'default', icon: Icons.circle, indicator: Icon(Icons.brightness_1, size: 22, color: Colors.grey)),
                TimelineEvent.icon(title: 'Red Override', description: 'Red line + indicator + growUp.', date: 'red', icon: Icons.circle, indicator: Icon(Icons.brightness_1, size: 26, color: Colors.red), themeOverride: const TimelineThemeData(lineColor: Colors.red, indicatorColor: Colors.red, indicatorSize: 26, connectorAnimation: ConnectorAnimation.growUp)),
                TimelineEvent.icon(title: 'Amber Override', description: 'Amber + pulse animation.', date: 'amber', icon: Icons.circle, indicator: Icon(Icons.brightness_1, size: 30, color: Colors.amber), themeOverride: const TimelineThemeData(lineColor: Colors.amber, indicatorColor: Colors.amber, indicatorSize: 30, connectorAnimation: ConnectorAnimation.pulse)),
                TimelineEvent.icon(title: 'Purple Override', description: 'Purple + wave + card color.', date: 'purple', icon: Icons.circle, indicator: Icon(Icons.brightness_1, size: 24, color: Colors.purple), themeOverride: const TimelineThemeData(lineColor: Colors.purple, indicatorColor: Colors.purple, cardBackground: Color(0xFFF3E5F5), connectorAnimation: ConnectorAnimation.wave)),
                TimelineEvent.icon(title: 'Default Again', description: 'Back to grey theme.', date: 'default', icon: Icons.circle, indicator: Icon(Icons.brightness_1, size: 22, color: Colors.grey)),
              ],
              showAnimation: true,
              animationController: _ctrl,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.teal.shade700, letterSpacing: 1),
      ),
    );
  }

  Widget _sectionSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
    );
  }

  Widget _fab(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 36,
      height: 36,
      child: FloatingActionButton.small(
        heroTag: null,
        onPressed: onPressed,
        child: Icon(icon, size: 18),
      ),
    );
  }
}

class IndicatorsTab extends StatelessWidget {
  const IndicatorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = TimelineThemeData(
      lineColor: Colors.indigo.shade300,
      lineWidth: 2.5,
      connectorAnimation: ConnectorAnimation.growDown,
      indicatorColor: Colors.indigo,
      indicatorSize: 28,
      cardBackground: Colors.white,
      cardElevation: 1,
      cardPadding: const EdgeInsets.all(12),
      cardBorderRadius: BorderRadius.circular(8),
      titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      dateStyle: TextStyle(fontSize: 11, color: Colors.grey.shade500),
      descriptionStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      spacingBetweenEvents: 8,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('CUSTOM INDICATORS'),
          _sectionSubtitle('Use any widget as your timeline indicator via the indicator parameter.'),
          SizedBox(
            height: 280,
            child: BeautifulTimeline(
              theme: theme.copyWith(indicatorStyle: IndicatorStyle.custom),
              events: [
                TimelineEvent.icon(
                  title: 'Star Badge',
                  description: 'Custom star-shaped indicator with gradient.',
                  date: 'star',
                  icon: Icons.star,
                  indicator: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(colors: [Colors.amber, Colors.orange]),
                      boxShadow: [BoxShadow(color: Colors.amber.withValues(alpha: 0.4), blurRadius: 6)],
                    ),
                    child: const Icon(Icons.star, color: Colors.white, size: 16),
                  ),
                ),
                TimelineEvent.icon(
                  title: 'Avatar Photo',
                  description: 'Circular avatar image as indicator.',
                  date: 'avatar',
                  icon: Icons.person,
                  indicator: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/64?img=3'),
                  ),
                ),
                TimelineEvent.icon(
                  title: 'Diamond Shape',
                  description: 'Rotated square for a diamond look.',
                  date: 'diamond',
                  icon: Icons.diamond,
                  indicator: Transform.rotate(
                    angle: 0.785,
                    child: Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [BoxShadow(color: Colors.teal.withValues(alpha: 0.4), blurRadius: 4)],
                      ),
                    ),
                  ),
                ),
                TimelineEvent.icon(
                  title: 'Pulsing Dot',
                  description: 'Animated pulsing circle indicator.',
                  date: 'pulse',
                  icon: Icons.blur_on,
                  indicator: _PulsingDot(size: 20, color: Colors.purple),
                ),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('NUMBERED INDICATORS'),
          _sectionSubtitle('Use IndicatorStyle.number for step-by-step timelines.'),
          SizedBox(
            height: 280,
            child: BeautifulTimeline(
              theme: theme.copyWith(indicatorStyle: IndicatorStyle.number, indicatorColor: Colors.deepOrange, indicatorSize: 32),
              events: [
                TimelineEvent.icon(title: 'Planning', description: 'Define scope and goals.', date: 'step 1', icon: Icons.looks_one),
                TimelineEvent.icon(title: 'Development', description: 'Build and iterate.', date: 'step 2', icon: Icons.looks_two),
                TimelineEvent.icon(title: 'Testing', description: 'QA and bug fixes.', date: 'step 3', icon: Icons.looks_3),
                TimelineEvent.icon(title: 'Launch', description: 'Deploy to production.', date: 'step 4', icon: Icons.looks_4),
              ],
              showAnimation: true,
            ),
          ),
          _sectionHeader('COLOR VARIATIONS'),
          _sectionSubtitle('Override indicator color per event via indicatorColor on TimelineEvent.'),
          SizedBox(
            height: 240,
            child: BeautifulTimeline(
              theme: theme.copyWith(indicatorStyle: IndicatorStyle.circle, indicatorColor: Colors.grey, indicatorSize: 24),
              events: [
                TimelineEvent.icon(title: 'Red Alert', description: 'Critical system notification.', date: 'red', icon: Icons.warning, indicatorColor: Colors.red),
                TimelineEvent.icon(title: 'Green Light', description: 'All systems operational.', date: 'green', icon: Icons.check_circle, indicatorColor: Colors.green),
                TimelineEvent.icon(title: 'Blue Info', description: 'Informational update.', date: 'blue', icon: Icons.info, indicatorColor: Colors.blue),
                TimelineEvent.icon(title: 'Amber Warning', description: 'Review recommended.', date: 'amber', icon: Icons.warning, indicatorColor: Colors.amber),
              ],
              showAnimation: true,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.indigo.shade700, letterSpacing: 1),
      ),
    );
  }

  Widget _sectionSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
    );
  }
}

class CustomizerTab extends StatefulWidget {
  const CustomizerTab({super.key});

  @override
  State<CustomizerTab> createState() => _CustomizerTabState();
}

class _CustomizerTabState extends State<CustomizerTab> {
  TimelineAxis _axis = TimelineAxis.vertical;
  Color _lineColor = Colors.blue;
  double _lineWidth = 2.5;
  LineStyle _lineStyle = LineStyle.solid;
  Color _lineGradientStart = Colors.purple;
  Color _lineGradientEnd = Colors.blue;
  Color _indicatorColor = Colors.blue;
  double _indicatorSize = 32;
  IndicatorStyle _indicatorStyle = IndicatorStyle.circle;
  Color _cardBackground = Colors.white;
  double _cardElevation = 2;
  double _cardBorderRadius = 12;
  ConnectorAnimation _animation = ConnectorAnimation.growDown;
  bool _reverse = false;
  bool _showAnimation = true;
  final ScrollController _hScrollController = ScrollController();

  @override
  void dispose() {
    _hScrollController.dispose();
    super.dispose();
  }

  static const _colors = [
    Colors.blue, Colors.teal, Colors.green, Colors.amber,
    Colors.orange, Colors.deepOrange, Colors.red, Colors.pink,
    Colors.purple, Colors.indigo, Colors.cyan, Colors.brown,
    Colors.blueGrey, Colors.grey, Colors.black, Colors.white,
  ];

  TimelineThemeData get _theme => TimelineThemeData(
    lineColor: _lineStyle == LineStyle.gradient ? _lineGradientStart : _lineColor,
    lineGradientStart: _lineStyle == LineStyle.gradient ? _lineGradientStart : null,
    lineGradientEnd: _lineStyle == LineStyle.gradient ? _lineGradientEnd : null,
    lineWidth: _lineWidth,
    lineStyle: _lineStyle,
    connectorAnimation: _animation,
    indicatorStyle: _indicatorStyle,
    indicatorColor: _indicatorColor,
    indicatorSize: _indicatorSize,
    cardBackground: _cardBackground,
    cardElevation: _cardElevation,
    cardPadding: const EdgeInsets.all(16),
    cardBorderRadius: BorderRadius.circular(_cardBorderRadius),
    titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
    dateStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
    descriptionStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.5),
    spacingBetweenEvents: 24,
    animationDuration: const Duration(milliseconds: 400),
    animationCurve: Curves.easeInOut,
  );

  static final _events = [
    TimelineEvent.icon(title: 'Project Start', description: 'Kickoff meeting with the team.', date: 'Jan', icon: Icons.rocket_launch),
    TimelineEvent.image(title: 'Design Phase', description: 'UI/UX mockups completed.', date: 'Feb', imageUrl: 'https://picsum.photos/seed/design/400/200', icon: Icons.design_services),
    TimelineEvent.progress(title: 'Development', description: 'Core features implemented.', label: 'Progress', value: 0.75, date: 'Mar', icon: Icons.code),
    TimelineEvent.icon(title: 'Beta Launch', description: 'Internal testing started.', date: 'Apr', icon: Icons.bug_report),
    TimelineEvent.expandable(title: 'Results', description: 'Tap to see metrics.', date: 'May', icon: Icons.analytics,
      expandedWidget: const Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          Text('Users: 12K', style: TextStyle(fontSize: 13)),
          Text('Rating: 4.8', style: TextStyle(fontSize: 13)),
        ]),
      ),
    ),
    TimelineEvent.icon(title: 'Public Launch', description: 'Released to production.', date: 'Jun', icon: Icons.celebration),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: _buildControls(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (_axis == TimelineAxis.horizontal) {
                    return Scrollbar(
                      controller: _hScrollController,
                      thumbVisibility: true,
                      child: BeautifulTimeline(
                        key: const ValueKey('customizer_timeline'),
                        axis: TimelineAxis.horizontal,
                        theme: _theme,
                        events: _events,
                        showAnimation: _showAnimation,
                        reverse: _reverse,
                        scrollController: _hScrollController,
                      ),
                    );
                  }
                  return BeautifulTimeline(
                    key: const ValueKey('customizer_timeline'),
                    axis: _axis,
                    theme: _theme,
                    events: _events,
                    showAnimation: _showAnimation,
                    reverse: _reverse,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CUSTOMIZE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade600, letterSpacing: 1)),
        const SizedBox(height: 8),
        _section('AXIS', _axisControl()),
        _section('LINE', _lineControls()),
        _section('INDICATOR', _indicatorControls()),
        _section('CARD', _cardControls()),
        _section('ANIMATION', _animationControls()),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _section(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey.shade500)),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  Widget _axisControl() {
    return SegmentedButton<TimelineAxis>(
      segments: const [
        ButtonSegment(value: TimelineAxis.vertical, label: Text('Vertical'), icon: Icon(Icons.vertical_align_top, size: 16)),
        ButtonSegment(value: TimelineAxis.horizontal, label: Text('Horizontal'), icon: Icon(Icons.horizontal_rule, size: 16)),
        ButtonSegment(value: TimelineAxis.responsive, label: Text('Auto'), icon: Icon(Icons.smartphone, size: 16)),
      ],
      selected: {_axis},
      onSelectionChanged: (s) => setState(() => _axis = s.first),
      showSelectedIcon: false,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 11)),
      ),
    );
  }

  Widget _lineControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _colorRow('Color', _lineColor, (c) => _lineColor = c),
        if (_lineStyle == LineStyle.gradient) ...[
          _colorRow('Gradient start', _lineGradientStart, (c) => _lineGradientStart = c),
          _colorRow('Gradient end', _lineGradientEnd, (c) => _lineGradientEnd = c),
        ],
        _sliderRow('Width', _lineWidth, 1, 6, (v) => _lineWidth = v),
        _dropdownRow<LineStyle>('Style', _lineStyle, LineStyle.values, (v) => _lineStyle = v),
      ],
    );
  }

  Widget _indicatorControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dropdownRow<IndicatorStyle>('Style', _indicatorStyle, IndicatorStyle.values, (v) => _indicatorStyle = v),
        _colorRow('Color', _indicatorColor, (c) => _indicatorColor = c),
        _sliderRow('Size', _indicatorSize, 16, 52, (v) => _indicatorSize = v),
      ],
    );
  }

  Widget _cardControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _colorRow('Background', _cardBackground, (c) => _cardBackground = c),
        _sliderRow('Elevation', _cardElevation, 0, 10, (v) => _cardElevation = v),
        _sliderRow('Border radius', _cardBorderRadius, 0, 30, (v) => _cardBorderRadius = v),
      ],
    );
  }

  Widget _animationControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dropdownRow<ConnectorAnimation>('Style', _animation, ConnectorAnimation.values, (v) => _animation = v),
        Row(
          children: [
            const Text('Reverse', style: TextStyle(fontSize: 12)),
            Switch(value: _reverse, onChanged: (v) => setState(() => _reverse = v), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
            const SizedBox(width: 16),
            const Text('Animate', style: TextStyle(fontSize: 12)),
            Switch(value: _showAnimation, onChanged: (v) => setState(() => _showAnimation = v), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ],
        ),
      ],
    );
  }

  Widget _colorRow(String label, Color color, ValueChanged<Color> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 12))),
          const SizedBox(width: 4),
          ..._colors.map((c) => GestureDetector(
            onTap: () => setState(() => onChanged(c)),
            child: Container(
              width: 20, height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  color: c == color ? Colors.black : Colors.grey.shade300,
                  width: c == color ? 2.5 : 1,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _sliderRow(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 12))),
          Expanded(
            child: Slider(
              value: value, min: min, max: max,
              onChanged: (v) => setState(() => onChanged(v)),
            ),
          ),
          SizedBox(width: 36, child: Text(value.toStringAsFixed(1), style: const TextStyle(fontSize: 11))),
        ],
      ),
    );
  }

  Widget _dropdownRow<T>(String label, T value, List<T> items, ValueChanged<T> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 12))),
          Expanded(
            child: DropdownButtonFormField<T>(
              initialValue: value,
              isDense: true,
              onChanged: (v) {
                if (v != null) setState(() => onChanged(v));
              },
              items: items.map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.toString().split('.').last, style: const TextStyle(fontSize: 12)),
              )).toList(),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final double size;
  final Color color;
  const _PulsingDot({required this.size, required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _anim,
      builder: (context, _) => Transform.scale(
        scale: _anim.value,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.5),
                blurRadius: 8 * _anim.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
