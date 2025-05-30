import 'package:pigeon/pigeon.dart';

// Flutter側から呼び出すメソッド
@HostApi()
abstract class CalendarApi {
  String getPlatformVersion(); // 動作確認用メソッド
}
