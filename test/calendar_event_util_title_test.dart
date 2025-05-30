import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('CalendarEvent title test', () {
    test('タイトルが空文字でも処理できる', () {
      final events = [
        CalendarEvent(
          title: '',
          description: 'No title',
          location: 'Tokyo',
          startTimeMillis: 1000,
          endTimeMillis: 2000,
        ),
        CalendarEvent(
          title: 'Meeting',
          description: 'Work',
          location: 'Office',
          startTimeMillis: 500,
          endTimeMillis: 1500,
        ),
      ];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.first.title, 'Meeting');
      expect(sorted.last.title, '');
    });

    test('タイトルがnullでも処理できる（nullableを許す場合）', () {
      final events = [
        CalendarEvent(
          title: null,
          description: 'Null title',
          location: 'Unknown',
          startTimeMillis: 1000,
          endTimeMillis: 2000,
        ),
      ];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.first.title, isNull);
    });
  });
}
