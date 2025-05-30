import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('sortEventsByStartTime - null startTimeMillis', () {
    test('null を含むイベントも 0 扱いでソートできる', () {
      final events = [
        CalendarEvent(title: 'イベントA', description: '', location: '', startTimeMillis: 1000, endTimeMillis: 2000),
        CalendarEvent(title: 'イベントB', description: '', location: '', startTimeMillis: null, endTimeMillis: 1500),
        CalendarEvent(title: 'イベントC', description: '', location: '', startTimeMillis: 500, endTimeMillis: 1000),
      ];

      final sorted = sortEventsByStartTime(events);

      expect(sorted[0].title, 'イベントB'); // null → 0 として扱う
      expect(sorted[1].title, 'イベントC');
      expect(sorted[2].title, 'イベントA');
    });
  });
}
