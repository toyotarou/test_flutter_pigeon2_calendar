import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('sortEventsByStartTime - already sorted list', () {
    test('ソート済みのリストはそのままの順序で返される', () {
      final event1 = CalendarEvent(
        title: 'Event 1',
        description: '',
        location: '',
        startTimeMillis: 1000,
        endTimeMillis: 2000,
      );
      final event2 = CalendarEvent(
        title: 'Event 2',
        description: '',
        location: '',
        startTimeMillis: 2000,
        endTimeMillis: 3000,
      );
      final event3 = CalendarEvent(
        title: 'Event 3',
        description: '',
        location: '',
        startTimeMillis: 3000,
        endTimeMillis: 4000,
      );

      final events = [event1, event2, event3];

      final sorted = sortEventsByStartTime(events);

      expect(sorted, equals(events));
    });
  });
}
