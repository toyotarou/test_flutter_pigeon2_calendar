import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';

void main() {
  test('イベントを開始時刻でソートできる', () {
    final events = [
      CalendarEvent(title: 'B', startTimeMillis: 2000),
      CalendarEvent(title: 'A', startTimeMillis: 1000),
      CalendarEvent(title: 'C', startTimeMillis: 3000),
    ];

    final sorted = sortEventsByStartTime(events);

    expect(sorted[0].title, 'A');
    expect(sorted[1].title, 'B');
    expect(sorted[2].title, 'C');
  });
}
