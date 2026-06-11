import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beautiful_timeline/beautiful_timeline.dart';

void main() {
  // ── Theme & CopyWith ──────────────────────────────────────────────
  test('TimelineThemeData copyWith works', () {
    const theme = TimelineThemeData(
      lineWidth: 2.0,
      indicatorSize: 32.0,
      cardElevation: 2.0,
    );
    final copy = theme.copyWith(lineWidth: 4.0);
    expect(copy.lineWidth, 4.0);
    expect(copy.indicatorSize, 32.0);
    expect(copy.cardElevation, 2.0);
  });

  test('TimelineThemeData defaults', () {
    const theme = TimelineThemeData();
    expect(theme.connectorAnimation, ConnectorAnimation.growDown);
    expect(theme.effect, TimelineEffect.none);
    expect(theme.lineStyle, LineStyle.solid);
    expect(theme.indicatorStyle, IndicatorStyle.circle);
    expect(theme.lineWidth, 2.5);
    expect(theme.indicatorSize, 32.0);
    expect(theme.cardElevation, 1.0);
    expect(theme.animationDuration, const Duration(milliseconds: 400));
  });

  test('TimelineThemeData copyWith effect', () {
    const theme = TimelineThemeData(effect: TimelineEffect.glow);
    expect(theme.effect, TimelineEffect.glow);
    final copy = theme.copyWith(effect: TimelineEffect.shimmer);
    expect(copy.effect, TimelineEffect.shimmer);
    expect(copy.connectorAnimation, ConnectorAnimation.growDown);
  });

  test('TimelineThemeData copyWith connectorAnimation', () {
    const theme = TimelineThemeData(connectorAnimation: ConnectorAnimation.stagger);
    expect(theme.connectorAnimation, ConnectorAnimation.stagger);
    expect(theme.copyWith(connectorAnimation: ConnectorAnimation.wipe).connectorAnimation, ConnectorAnimation.wipe);
    expect(theme.copyWith(connectorAnimation: ConnectorAnimation.glow).connectorAnimation, ConnectorAnimation.glow);
    expect(theme.copyWith(connectorAnimation: ConnectorAnimation.ripple).connectorAnimation, ConnectorAnimation.ripple);
    expect(theme.copyWith(connectorAnimation: ConnectorAnimation.morph).connectorAnimation, ConnectorAnimation.morph);
    expect(theme.copyWith(connectorAnimation: ConnectorAnimation.slideIn).connectorAnimation, ConnectorAnimation.slideIn);
  });

  test('TimelineEffect enum has all values', () {
    expect(TimelineEffect.values.length, 4);
    expect(TimelineEffect.values, contains(TimelineEffect.none));
    expect(TimelineEffect.values, contains(TimelineEffect.glow));
    expect(TimelineEffect.values, contains(TimelineEffect.shimmer));
    expect(TimelineEffect.values, contains(TimelineEffect.sparkle));
  });

  // ── ConnectorAnimation Enum ───────────────────────────────────────
  test('ConnectorAnimation has all 14 values', () {
    expect(ConnectorAnimation.values.length, 14);
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.growDown));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.growUp));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.growOut));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.wave));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.pulse));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.draw));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.fadeIn));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.bounce));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.stagger));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.wipe));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.glow));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.ripple));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.morph));
    expect(ConnectorAnimation.values, contains(ConnectorAnimation.slideIn));
  });

  // ── TimelineEvent Constructors ────────────────────────────────────
  test('TimelineEvent creates text event', () {
    final event = TimelineEvent.text(
      title: 'Test',
      description: 'Description',
      date: 'Jan 2026',
    );
    expect(event.title, 'Test');
    expect(event.description, 'Description');
    expect(event.date, 'Jan 2026');
  });

  test('TimelineEvent creates progress event with clamped value', () {
    final event = TimelineEvent.progress(
      label: 'Progress',
      value: 1.5,
    );
    expect(event.progressLabel, 'Progress');
    expect(event.progressValue, 1.0);
  });

  test('TimelineEvent creates progress event with clamped low value', () {
    final event = TimelineEvent.progress(
      label: 'Progress',
      value: -0.5,
    );
    expect(event.progressValue, 0.0);
  });

  test('TimelineEvent creates progress event with exact value', () {
    final event = TimelineEvent.progress(label: 'Progress', value: 0.5);
    expect(event.progressValue, 0.5);
  });

  test('TimelineEvent creates progress event with default value', () {
    final event = TimelineEvent.progress(label: 'Progress', value: 0.0);
    expect(event.progressValue, 0.0);
  });

  test('TimelineEvent creates icon event', () {
    final event = TimelineEvent.icon(
      title: 'Icon Event',
      icon: Icons.star,
    );
    expect(event.title, 'Icon Event');
    expect(event.icon, Icons.star);
  });

  test('TimelineEvent creates icon event with default icon', () {
    final event = TimelineEvent.icon(title: 'No Icon', icon: Icons.circle);
    expect(event.title, 'No Icon');
    expect(event.icon, Icons.circle);
  });

  test('TimelineEvent creates custom event', () {
    final widget = const SizedBox(width: 100, height: 100);
    final event = TimelineEvent.custom(customWidget: widget);
    expect(event.customWidget, widget);
  });

  test('TimelineEvent creates expandable event', () {
    final expanded = const Text('Expanded content');
    final event = TimelineEvent.expandable(
      title: 'Expandable',
      expandedWidget: expanded,
    );
    expect(event.title, 'Expandable');
    expect(event.expandedWidget, expanded);
  });

  test('TimelineEvent creates card event', () {
    final card = const Text('Card content');
    final event = TimelineEvent.card(customWidget: card);
    expect(event.customWidget, card);
  });

  test('TimelineEvent creates image event', () {
    final event = TimelineEvent.image(
      title: 'Image Event',
      imageUrl: 'https://example.com/image.png',
    );
    expect(event.title, 'Image Event');
    expect(event.imageUrl, 'https://example.com/image.png');
  });

  test('TimelineEvent creates image event with default icon', () {
    final event = TimelineEvent.image(title: 'Img', imageUrl: 'https://example.com/a.png');
    expect(event.title, 'Img');
  });

  test('TimelineEvent creates imageWidget event', () {
    final widget = const SizedBox(width: 100, height: 100);
    final event = TimelineEvent.imageWidget(
      title: 'Widget Image',
      imageWidget: widget,
    );
    expect(event.title, 'Widget Image');
    expect(event.imageWidget, widget);
  });

  test('TimelineEvent creates video event', () {
    final event = TimelineEvent.video(
      title: 'Tutorial',
      thumbnailUrl: 'https://example.com/thumb.png',
      duration: '10:30',
    );
    expect(event.title, 'Tutorial');
    expect(event.icon, Icons.play_circle);
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates code event', () {
    final event = TimelineEvent.code(
      code: 'void main() {}',
      language: 'Dart',
    );
    expect(event.title, 'Dart');
    expect(event.icon, Icons.code);
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates code event with default language', () {
    final event = TimelineEvent.code(code: 'print(1)', language: 'Dart');
    expect(event.title, 'Dart');
  });

  test('TimelineEvent creates quote event', () {
    final event = TimelineEvent.quote(
      quote: 'Hello',
      author: 'Author',
    );
    expect(event.icon, Icons.format_quote);
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates quote event without author', () {
    final event = TimelineEvent.quote(quote: 'Alone', author: '');
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates link event', () {
    final event = TimelineEvent.link(
      url: 'https://example.com',
      label: 'Example',
    );
    expect(event.icon, Icons.link);
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates link event with default label', () {
    final event = TimelineEvent.link(url: 'https://example.com', label: 'https://example.com');
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates tags event', () {
    final event = TimelineEvent.tags(
      tags: ['flutter', 'dart'],
      title: 'Tech',
    );
    expect(event.title, 'Tech');
    expect(event.icon, Icons.label);
  });

  test('TimelineEvent creates tags event empty list', () {
    final event = TimelineEvent.tags(tags: [], title: 'Empty');
    expect(event.title, 'Empty');
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates stats event', () {
    final event = TimelineEvent.stats(
      stats: {'Users': '1K'},
      title: 'Metrics',
    );
    expect(event.title, 'Metrics');
    expect(event.icon, Icons.bar_chart);
  });

  test('TimelineEvent creates stats event empty map', () {
    final event = TimelineEvent.stats(stats: {}, title: 'No Stats');
    expect(event.title, 'No Stats');
  });

  test('TimelineEvent creates avatar event', () {
    final event = TimelineEvent.avatar(
      name: 'Alice',
      avatarUrl: 'https://example.com/avatar.png',
    );
    expect(event.icon, Icons.person);
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates avatar event without image', () {
    final event = TimelineEvent.avatar(name: 'Bob', avatarUrl: '');
    expect(event.icon, Icons.person);
    expect(event.customWidget, isA<Widget>());
  });

  test('TimelineEvent creates event with number', () {
    final event = TimelineEvent.text(
      title: 'Step',
      number: 3,
    );
    expect(event.number, 3);
  });

  test('TimelineEvent creates event with null number', () {
    final event = TimelineEvent.text(title: 'No Number');
    expect(event.number, isNull);
  });

  // ── TimelineThemes ────────────────────────────────────────────────
  test('TimelineThemes provides all 20 themes', () {
    expect(TimelineThemes.minimal(), isA<TimelineThemeData>());
    expect(TimelineThemes.modern(), isA<TimelineThemeData>());
    expect(TimelineThemes.gradient(), isA<TimelineThemeData>());
    expect(TimelineThemes.card(), isA<TimelineThemeData>());
    expect(TimelineThemes.cupertino(), isA<TimelineThemeData>());
    expect(TimelineThemes.material(), isA<TimelineThemeData>());
    expect(TimelineThemes.dark(), isA<TimelineThemeData>());
    expect(TimelineThemes.neumorphic(), isA<TimelineThemeData>());
    expect(TimelineThemes.dotted(), isA<TimelineThemeData>());
    expect(TimelineThemes.bubble(), isA<TimelineThemeData>());
    expect(TimelineThemes.sunset(), isA<TimelineThemeData>());
    expect(TimelineThemes.ocean(), isA<TimelineThemeData>());
    expect(TimelineThemes.forest(), isA<TimelineThemeData>());
    expect(TimelineThemes.galaxy(), isA<TimelineThemeData>());
    expect(TimelineThemes.retro(), isA<TimelineThemeData>());
    expect(TimelineThemes.neon(), isA<TimelineThemeData>());
    expect(TimelineThemes.pastel(), isA<TimelineThemeData>());
    expect(TimelineThemes.luxury(), isA<TimelineThemeData>());
    expect(TimelineThemes.cyberpunk(), isA<TimelineThemeData>());
    expect(TimelineThemes.coffee(), isA<TimelineThemeData>());
  });

  test('TimelineThemes have distinct names', () {
    final themes = <TimelineThemeData>[
      TimelineThemes.minimal(),
      TimelineThemes.modern(),
      TimelineThemes.gradient(),
      TimelineThemes.card(),
      TimelineThemes.cupertino(),
      TimelineThemes.material(),
      TimelineThemes.dark(),
      TimelineThemes.neumorphic(),
      TimelineThemes.dotted(),
      TimelineThemes.bubble(),
      TimelineThemes.sunset(),
      TimelineThemes.ocean(),
      TimelineThemes.forest(),
      TimelineThemes.galaxy(),
      TimelineThemes.retro(),
      TimelineThemes.neon(),
      TimelineThemes.pastel(),
      TimelineThemes.luxury(),
      TimelineThemes.cyberpunk(),
      TimelineThemes.coffee(),
    ];
    expect(themes.length, 20);
    // All have valid lineWidth
    for (final t in themes) {
      expect(t.lineWidth, greaterThan(0));
      expect(t.indicatorSize, greaterThan(0));
    }
  });

  // ── TimelineAxis Enum ─────────────────────────────────────────────
  test('TimelineAxis has all 3 values', () {
    expect(TimelineAxis.values.length, 3);
    expect(TimelineAxis.values, contains(TimelineAxis.vertical));
    expect(TimelineAxis.values, contains(TimelineAxis.horizontal));
    expect(TimelineAxis.values, contains(TimelineAxis.responsive));
  });

  // ── LineStyle Enum ────────────────────────────────────────────────
  test('LineStyle has all 4 values', () {
    expect(LineStyle.values.length, 4);
    expect(LineStyle.values, contains(LineStyle.solid));
    expect(LineStyle.values, contains(LineStyle.dotted));
    expect(LineStyle.values, contains(LineStyle.dashed));
    expect(LineStyle.values, contains(LineStyle.gradient));
  });

  // ── IndicatorStyle Enum ───────────────────────────────────────────
  test('IndicatorStyle has all 4 values', () {
    expect(IndicatorStyle.values.length, 4);
    expect(IndicatorStyle.values, contains(IndicatorStyle.circle));
    expect(IndicatorStyle.values, contains(IndicatorStyle.icon));
    expect(IndicatorStyle.values, contains(IndicatorStyle.number));
    expect(IndicatorStyle.values, contains(IndicatorStyle.custom));
  });

  // ── Widget Tests ──────────────────────────────────────────────────
  testWidgets('BeautifulTimeline renders with events', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [
          TimelineEvent.text(title: 'Event 1', date: 'Jan'),
          TimelineEvent.text(title: 'Event 2', date: 'Feb'),
        ],
        showAnimation: false,
      ),
    ));
    expect(find.text('Event 1'), findsOneWidget);
    expect(find.text('Event 2'), findsOneWidget);
    expect(find.text('Jan'), findsOneWidget);
    expect(find.text('Feb'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with single event', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.text(title: 'Solo', date: 'Only')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Solo'), findsOneWidget);
    expect(find.text('Only'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with many events', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SingleChildScrollView(
        child: BeautifulTimeline(
          events: List.generate(20, (i) => TimelineEvent.text(title: 'E$i', date: 'D$i')),
          showAnimation: false,
        ),
      ),
    ));
    expect(find.text('E0'), findsOneWidget);
    expect(find.text('E19'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with custom theme', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: TimelineThemes.dark(),
        events: [
          TimelineEvent.text(title: 'Dark Event', date: 'Test'),
        ],
        showAnimation: false,
      ),
    ));
    expect(find.text('Dark Event'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders horizontal axis', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SizedBox(
        height: 400,
        width: 800,
        child: BeautifulTimeline(
          axis: TimelineAxis.horizontal,
          events: [
            TimelineEvent.text(title: 'H1', date: 'A'),
            TimelineEvent.text(title: 'H2', date: 'B'),
          ],
          showAnimation: false,
        ),
      ),
    ));
    expect(find.text('H1'), findsOneWidget);
    expect(find.text('H2'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with reverse', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SizedBox(
        height: 400,
        child: BeautifulTimeline(
          reverse: true,
          events: [
            TimelineEvent.text(title: 'First', date: 'A'),
            TimelineEvent.text(title: 'Last', date: 'B'),
          ],
          showAnimation: false,
        ),
      ),
    ));
    expect(find.text('First'), findsOneWidget);
    expect(find.text('Last'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with responsive axis', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        axis: TimelineAxis.responsive,
        events: [TimelineEvent.text(title: 'Resp', date: 'R')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Resp'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders icon event', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.icon(title: 'Star', icon: Icons.star)],
        showAnimation: false,
      ),
    ));
    expect(find.text('Star'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders progress event', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.progress(title: 'Progress', value: 0.5, label: '50%')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Progress'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with indicatorStyle number', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(indicatorStyle: IndicatorStyle.number),
        events: [TimelineEvent.text(title: 'Numbered', number: 1)],
        showAnimation: false,
      ),
    ));
    expect(find.text('Numbered'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with indicatorStyle custom', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(indicatorStyle: IndicatorStyle.custom),
        events: [TimelineEvent.text(title: 'Custom', indicator: const Icon(Icons.star))],
        showAnimation: false,
      ),
    ));
    expect(find.text('Custom'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with expandable event', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [
          TimelineEvent.expandable(
            title: 'Expandable',
            expandedWidget: const Text('Expanded!'),
          ),
        ],
        showAnimation: false,
      ),
    ));
    expect(find.text('Expandable'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
    // Tap to expand
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    expect(find.text('Expanded!'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with card event', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [
          TimelineEvent.card(
            customWidget: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Card Body'),
            ),
          ),
        ],
        showAnimation: false,
      ),
    ));
    expect(find.text('Card Body'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders custom event', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [
          TimelineEvent.custom(
            customWidget: const SizedBox(height: 50, child: Text('Custom Widget')),
          ),
        ],
        showAnimation: false,
      ),
    ));
    expect(find.text('Custom Widget'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with all indicator styles', (tester) async {
    for (final style in IndicatorStyle.values) {
      await tester.pumpWidget(MaterialApp(
        home: BeautifulTimeline(
          theme: TimelineThemeData(indicatorStyle: style),
          events: [
            TimelineEvent.icon(title: 'Style ${style.name}', icon: Icons.star),
          ],
          showAnimation: false,
        ),
      ));
      expect(find.text('Style ${style.name}'), findsOneWidget);
    }
  });

  testWidgets('BeautifulTimeline renders with effect glow', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(effect: TimelineEffect.glow),
        events: [TimelineEvent.text(title: 'Glow Effect')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Glow Effect'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with effect sparkle', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(effect: TimelineEffect.sparkle),
        events: [TimelineEvent.text(title: 'Sparkle Effect')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Sparkle Effect'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with effect shimmer', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(effect: TimelineEffect.shimmer),
        events: [TimelineEvent.text(title: 'Shimmer Effect')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Shimmer Effect'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with all connector animations', (tester) async {
    for (final anim in ConnectorAnimation.values) {
      await tester.pumpWidget(MaterialApp(
        home: SizedBox(
          height: 200,
          child: BeautifulTimeline(
            theme: TimelineThemeData(connectorAnimation: anim),
            events: [
              TimelineEvent.text(title: 'Anim ${anim.name}', date: 'Test'),
            ],
            showAnimation: true,
          ),
        ),
      ));
      expect(find.text('Anim ${anim.name}'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
    }
  });

  testWidgets('BeautifulTimeline renders with line styles', (tester) async {
    for (final style in LineStyle.values) {
      await tester.pumpWidget(MaterialApp(
        home: BeautifulTimeline(
          theme: TimelineThemeData(lineStyle: style),
          events: [TimelineEvent.text(title: 'Style ${style.name}')],
          showAnimation: false,
        ),
      ));
      expect(find.text('Style ${style.name}'), findsOneWidget);
    }
  });

  testWidgets('BeautifulTimeline with animation plays', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.text(title: 'Animated', date: 'Play')],
        showAnimation: true,
      ),
    ));
    expect(find.text('Animated'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    // Widget should still be there after pump
    expect(find.text('Animated'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with custom animation duration', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(animationDuration: Duration(seconds: 2)),
        events: [TimelineEvent.text(title: 'Slow')],
        showAnimation: true,
      ),
    ));
    expect(find.text('Slow'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Slow'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline horizontal with custom itemWidth', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SizedBox(
        height: 400,
        width: 800,
        child: BeautifulTimeline(
          axis: TimelineAxis.horizontal,
          itemWidth: 200,
          events: [
            TimelineEvent.text(title: 'Wide', date: 'A'),
            TimelineEvent.text(title: 'Wide2', date: 'B'),
          ],
          showAnimation: false,
        ),
      ),
    ));
    expect(find.text('Wide'), findsOneWidget);
    expect(find.text('Wide2'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline reverse horizontal', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SizedBox(
        height: 400,
        width: 800,
        child: BeautifulTimeline(
          axis: TimelineAxis.horizontal,
          reverse: true,
          events: [
            TimelineEvent.text(title: 'Rev1', date: 'A'),
            TimelineEvent.text(title: 'Rev2', date: 'B'),
          ],
          showAnimation: false,
        ),
      ),
    ));
    expect(find.text('Rev1'), findsOneWidget);
    expect(find.text('Rev2'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline renders with multiple events and different types', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SingleChildScrollView(
        child: BeautifulTimeline(
          events: [
            TimelineEvent.text(title: 'Text', date: '1'),
            TimelineEvent.icon(title: 'Icon', date: '2', icon: Icons.star),
            TimelineEvent.progress(title: 'Progress', value: 0.7, label: '70%', date: '3'),
            TimelineEvent.image(title: 'Image', date: '4', imageUrl: 'https://example.com/i.png'),
          ],
          showAnimation: false,
        ),
      ),
    ));
    expect(find.text('Text'), findsOneWidget);
    expect(find.text('Icon'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Image'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with all effects renders', (tester) async {
    for (final effect in TimelineEffect.values) {
      await tester.pumpWidget(MaterialApp(
        home: BeautifulTimeline(
          theme: TimelineThemeData(effect: effect),
          events: [TimelineEvent.text(title: 'Effect ${effect.name}')],
          showAnimation: false,
        ),
      ));
      expect(find.text('Effect ${effect.name}'), findsOneWidget);
    }
  });

  testWidgets('BeautifulTimeline with code event renders', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.code(code: 'print("hi")', language: 'Python')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Python'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with quote event renders', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.quote(quote: 'Hello World', author: 'Me')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Hello World'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with tags event renders', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.tags(tags: ['a', 'b', 'c'], title: 'Tags')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Tags'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with stats event renders', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.stats(stats: {'Views': '500'}, title: 'Stats')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Stats'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with link event renders', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.link(url: 'https://flutter.dev', label: 'Flutter')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Flutter'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with avatar event renders', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.avatar(name: 'John', avatarUrl: 'https://example.com/j.png')],
        showAnimation: false,
      ),
    ));
    expect(find.text('John'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with gradient line style', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: TimelineThemeData(
          lineStyle: LineStyle.gradient,
          lineGradientStart: Colors.red,
          lineGradientEnd: Colors.blue,
        ),
        events: [TimelineEvent.text(title: 'Gradient')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Gradient'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with dotted line style', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(lineStyle: LineStyle.dotted),
        events: [TimelineEvent.text(title: 'Dotted')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Dotted'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with dashed line style', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        theme: const TimelineThemeData(lineStyle: LineStyle.dashed),
        events: [TimelineEvent.text(title: 'Dashed')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Dashed'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline empty events renders without error', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [],
        showAnimation: false,
      ),
    ));
    // Should not throw and render empty state
    expect(find.byType(BeautifulTimeline), findsOneWidget);
  });

  testWidgets('BeautifulTimeline with null theme uses default', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.text(title: 'Default Theme')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Default Theme'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline animation controller resets and replays', (tester) async {
    final controller = TimelineAnimationController(vsync: tester);
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        animationController: controller,
        events: [TimelineEvent.text(title: 'Replay')],
        showAnimation: true,
      ),
    ));
    expect(find.text('Replay'), findsOneWidget);
    controller.reset();
    controller.forward();
    await tester.pumpAndSettle();
    expect(find.text('Replay'), findsOneWidget);
    controller.dispose();
  });

  testWidgets('BeautifulTimeline with themeOverride renders', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [
          TimelineEvent.text(
            title: 'Override',
            themeOverride: const TimelineThemeData(lineColor: Colors.red),
          ),
        ],
        showAnimation: false,
      ),
    ));
    expect(find.text('Override'), findsOneWidget);
  });

  // ── Responsive Tests ──────────────────────────────────────────────
  testWidgets('BeautifulTimeline responsive axis on small screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 800));
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        axis: TimelineAxis.responsive,
        events: [TimelineEvent.text(title: 'Mobile', date: 'M')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Mobile'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline responsive axis on large screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        axis: TimelineAxis.responsive,
        events: [TimelineEvent.text(title: 'Desktop', date: 'D')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Desktop'), findsOneWidget);
  });

  // ── TimelineBreakpoint ────────────────────────────────────────────
  test('TimelineBreakpoint defaults', () {
    const bp = TimelineBreakpoint();
    expect(bp.mobile, 600);
    expect(bp.tablet, 900);
  });

  test('TimelineBreakpoint custom values', () {
    const bp = TimelineBreakpoint(mobile: 400, tablet: 700);
    expect(bp.mobile, 400);
    expect(bp.tablet, 700);
  });

  // ── LinearProgressIndicator in progress event ─────────────────────
  testWidgets('BeautifulTimeline progress event shows indicator', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [
          TimelineEvent.progress(title: 'Progress', value: 0.75, label: '75%'),
        ],
        showAnimation: false,
      ),
    ));
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('75%'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline progress event at 0', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.progress(title: 'Zero', value: 0.0, label: '0%')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Zero'), findsOneWidget);
  });

  testWidgets('BeautifulTimeline progress event at 1', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeautifulTimeline(
        events: [TimelineEvent.progress(title: 'Full', value: 1.0, label: '100%')],
        showAnimation: false,
      ),
    ));
    expect(find.text('Full'), findsOneWidget);
  });
}
