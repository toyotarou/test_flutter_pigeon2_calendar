// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/main.dart';

void main() {
  testWidgets('App starts without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
