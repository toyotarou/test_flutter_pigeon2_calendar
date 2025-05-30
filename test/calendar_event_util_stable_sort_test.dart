import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('sortEventsByStartTime - stable sort', () {
    test('同一 startTimeMillis のイベントの順番が保持される', () {
      final event1 = CalendarEvent(
        title: 'Event A',
        description: '',
        location: '',
        startTimeMillis: 2000,
        endTimeMillis: 2500,
      );
      final event2 = CalendarEvent(
        title: 'Event B',
        description: '',
        location: '',
        startTimeMillis: 2000,
        endTimeMillis: 2600,
      );
      final event3 = CalendarEvent(
        title: 'Event C',
        description: '',
        location: '',
        startTimeMillis: 1000,
        endTimeMillis: 1500,
      );

      final events = [event1, event2, event3];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.length, 3);
      expect(sorted[0].title, 'Event C');
      expect(sorted[1].title, 'Event A');
      expect(sorted[2].title, 'Event B');
    });
  });
}
