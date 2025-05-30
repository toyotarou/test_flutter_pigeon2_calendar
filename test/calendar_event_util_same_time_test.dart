import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('sortEventsByStartTime - same start time', () {
    test('同じ startTimeMillis の順序は保持される', () {
      final events = [
        CalendarEvent(title: 'イベントA', description: '', location: '', startTimeMillis: 1000, endTimeMillis: 2000),
        CalendarEvent(title: 'イベントB', description: '', location: '', startTimeMillis: 500, endTimeMillis: 1000),
        CalendarEvent(title: 'イベントC', description: '', location: '', startTimeMillis: 1000, endTimeMillis: 3000),
      ];

      final sorted = sortEventsByStartTime(events);

      expect(sorted[0].title, 'イベントB'); // 500
      expect(sorted[1].title, 'イベントA'); // 1000
      expect(sorted[2].title, 'イベントC'); // 1000（元の順序を維持しているか確認）
    });
  });
}
