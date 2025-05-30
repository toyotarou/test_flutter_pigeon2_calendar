import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('sortEventsByStartTime - all null start times', () {
    test('startTimeMillis がすべて null の場合、元の順序のまま返る', () {
      final event1 = CalendarEvent(
        title: 'Null Event 1',
        description: '',
        location: '',
        startTimeMillis: null,
        endTimeMillis: 1000,
      );
      final event2 = CalendarEvent(
        title: 'Null Event 2',
        description: '',
        location: '',
        startTimeMillis: null,
        endTimeMillis: 2000,
      );

      final events = [event1, event2];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.length, 2);
      expect(sorted[0].title, 'Null Event 1');
      expect(sorted[1].title, 'Null Event 2');
    });
  });
}
