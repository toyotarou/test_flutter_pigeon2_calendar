// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/main.dart'; // あなたの main.dart のパスに合わせる

void main() {
  testWidgets('アプリが MyApp を一つ描画する', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // MyApp（MaterialAppなど）を一つだけ描画しているか
    expect(find.byType(MyApp), findsOneWidget);
  });
}
