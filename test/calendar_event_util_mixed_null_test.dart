import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('sortEventsByStartTime - mixed nulls', () {
    test('startTimeMillis に null を含むイベントがあっても正しくソートされる', () {
      final event1 = CalendarEvent(
        title: 'Event with 3000',
        description: '',
        location: '',
        startTimeMillis: 3000,
        endTimeMillis: 4000,
      );
      final event2 = CalendarEvent(
        title: 'Null Event',
        description: '',
        location: '',
        startTimeMillis: null,
        endTimeMillis: 2000,
      );
      final event3 = CalendarEvent(
        title: 'Event with 1000',
        description: '',
        location: '',
        startTimeMillis: 1000,
        endTimeMillis: 1500,
      );

      final events = [event1, event2, event3];

      final sorted = sortEventsByStartTime(events);

      expect(sorted.length, 3);
      expect(sorted[0].title, 'Null Event'); // null は 0 として扱う
      expect(sorted[1].title, 'Event with 1000');
      expect(sorted[2].title, 'Event with 3000');
    });
  });
}
