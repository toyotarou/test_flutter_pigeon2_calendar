// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/main.dart'; // あなたのエントリーポイント

void main() {
  testWidgets('App starts without errors', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
