// Autogenerated from Pigeon (v25.3.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

bool _deepEquals(Object? a, Object? b) {
  if (a is List && b is List) {
    return a.length == b.length && a.indexed.every(((int, dynamic) item) => _deepEquals(item.$2, b[item.$1]));
  }
  if (a is Map && b is Map) {
    return a.length == b.length &&
        a.entries.every(
          (MapEntry<Object?, Object?> entry) =>
              (b as Map<Object?, Object?>).containsKey(entry.key) && _deepEquals(entry.value, b[entry.key]),
        );
  }
  return a == b;
}

class CalendarEvent {
  CalendarEvent({this.title, this.description, this.location, this.startTimeMillis, this.endTimeMillis});

  String? title;

  String? description;

  String? location;

  int? startTimeMillis;

  int? endTimeMillis;

  List<Object?> _toList() {
    return <Object?>[title, description, location, startTimeMillis, endTimeMillis];
  }

  Object encode() {
    return _toList();
  }

  static CalendarEvent decode(Object result) {
    result as List<Object?>;
    return CalendarEvent(
      title: result[0] as String?,
      description: result[1] as String?,
      location: result[2] as String?,
      startTimeMillis: result[3] as int?,
      endTimeMillis: result[4] as int?,
    );
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) {
    if (other is! CalendarEvent || other.runtimeType != runtimeType) {
      return false;
    }
    if (identical(this, other)) {
      return true;
    }
    return _deepEquals(encode(), other.encode());
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => Object.hashAll(_toList());
}

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();

  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is CalendarEvent) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        return CalendarEvent.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class CalendarApi {
  /// Constructor for [CalendarApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  CalendarApi({BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
    : pigeonVar_binaryMessenger = binaryMessenger,
      pigeonVar_messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<String> getPlatformVersion() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.pigeon_calendar_sample.CalendarApi.getPlatformVersion$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList = await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as String?)!;
    }
  }

  Future<List<CalendarEvent>> getCalendarEvents() async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.pigeon_calendar_sample.CalendarApi.getCalendarEvents$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(null);
    final List<Object?>? pigeonVar_replyList = await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as List<Object?>?)!.cast<CalendarEvent>();
    }
  }

  Future<void> addCalendarEvent(CalendarEvent event) async {
    final String pigeonVar_channelName =
        'dev.flutter.pigeon.pigeon_calendar_sample.CalendarApi.addCalendarEvent$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final Future<Object?> pigeonVar_sendFuture = pigeonVar_channel.send(<Object?>[event]);
    final List<Object?>? pigeonVar_replyList = await pigeonVar_sendFuture as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }
}
