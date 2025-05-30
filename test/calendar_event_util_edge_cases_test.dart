import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('CalendarEvent 異常・境界テスト', () {
    test('startTimeMillis が null の場合は 0 扱いでソートされる', () {
      final events = [
        CalendarEvent(title: 'Event A', startTimeMillis: 1000, endTimeMillis: 2000),
        CalendarEvent(
          title: 'Event B',
          startTimeMillis: null, // null 値
          endTimeMillis: 1500,
        ),
      ];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.first.title, 'Event B'); // null → 0 扱い
    });

    test('全ての startTimeMillis が null の場合、順序は変更されない', () {
      final events = [
        CalendarEvent(title: 'E1', startTimeMillis: null, endTimeMillis: 1),
        CalendarEvent(title: 'E2', startTimeMillis: null, endTimeMillis: 2),
        CalendarEvent(title: 'E3', startTimeMillis: null, endTimeMillis: 3),
      ];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.map((e) => e.title), ['E1', 'E2', 'E3']); // 元の順番のまま
    });

    test('同じ startTimeMillis を持つイベントの順序は変更されない', () {
      final events = [
        CalendarEvent(title: 'A', startTimeMillis: 1000, endTimeMillis: 2000),
        CalendarEvent(title: 'B', startTimeMillis: 1000, endTimeMillis: 1500),
        CalendarEvent(title: 'C', startTimeMillis: 1000, endTimeMillis: 2500),
      ];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.map((e) => e.title), ['A', 'B', 'C']);
    });

    test('イベントリストが空でもエラーにならない', () {
      final sorted = sortEventsByStartTime([]);
      expect(sorted, isEmpty);
    });

    test('イベントリストが1件でもエラーにならずそのまま返る', () {
      final single = CalendarEvent(title: 'Solo', startTimeMillis: 123, endTimeMillis: 456);
      final sorted = sortEventsByStartTime([single]);
      expect(sorted.length, 1);
      expect(sorted.first.title, 'Solo');
    });
  });
}
