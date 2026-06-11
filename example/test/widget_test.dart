import 'package:flutter_test/flutter_test.dart';

import 'package:beautiful_timeline_example/main.dart';

void main() {
  testWidgets('Timeline demo app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const TimelineDemoApp());
    // Let all Future.delayed animation timers fire (80ms * max events)
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Beautiful Timeline'), findsOneWidget);
  });
}
