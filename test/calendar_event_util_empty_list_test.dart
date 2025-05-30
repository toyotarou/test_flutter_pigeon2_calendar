import 'package:flutter_test/flutter_test.dart';
import 'package:pigeon_calendar_sample/calendar_event_util.dart';
import 'package:pigeon_calendar_sample/calendar_api.dart';

void main() {
  group('sortEventsByStartTime - empty list', () {
    test('空リストを渡すと空リストが返る', () {
      final events = <CalendarEvent>[];

      final sorted = sortEventsByStartTime(events);

      expect(sorted, isEmpty);
    });
  });
}
