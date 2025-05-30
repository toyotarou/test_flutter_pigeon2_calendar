// lib/calendar_event_util.dart

import 'calendar_api.dart';

List<CalendarEvent> sortEventsByStartTime(List<CalendarEvent> events) {
  return List<CalendarEvent>.from(events)..sort((a, b) => (a.startTimeMillis ?? 0).compareTo(b.startTimeMillis ?? 0));
}
