import 'package:flutter/material.dart';

import 'calendar_api.dart';

import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CalendarEvent> events = [];

  String status = '読み込み中...';

  ///
  @override
  void initState() {
    super.initState();

    init();
  }

  ///
  Future<void> init() async {
    final status = await Permission.calendar.status;

    print('初期状態: $status');

    final result = await Permission.calendar.request();

    print('リクエスト結果: $result');

    if (!result.isGranted) {
      setState(() => this.status = 'カレンダー権限が必要です（現在の状態: $result）');

      return;
    }

    await loadEvents();
  }

  ///
  Future<void> loadEvents() async {
    try {
      final api = CalendarApi();

      final eventList = await api.getCalendarEvents();

      setState(() {
        events = eventList;
        status = '取得成功';
      });
    } catch (e) {
      setState(() => status = 'エラー: $e');
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー予定一覧'),

        actions: [
          ElevatedButton(
            onPressed: () async {
              final now = DateTime.now();
              final event = CalendarEvent(
                title: 'テスト予定',
                description: 'pigeonから追加した予定',
                location: '東京',
                startTimeMillis: now.millisecondsSinceEpoch,
                endTimeMillis: now.add(const Duration(hours: 1)).millisecondsSinceEpoch,
              );

              final api = CalendarApi();
              await api.addCalendarEvent(event);

              setState(() {
                status = '予定を追加しました！';
              });

              await loadEvents();
            },
            child: const Text('予定を追加'),
          ),
        ],
      ),
      body:
          events.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(status),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Permission.calendar.request();
                        if (result.isGranted) {
                          await loadEvents();
                        } else {
                          setState(() => status = 'カレンダー権限が必要です（状態: $result）');
                        }
                      },
                      child: const Text('権限を再リクエスト'),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final e = events[index];

                  return ListTile(
                    title: Text(e.title ?? '無題'),
                    subtitle: Text('開始: ${DateTime.fromMillisecondsSinceEpoch(e.startTimeMillis ?? 0)}'),
                  );
                },
              ),
    );
  }
}
