import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'calendar_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'カレンダー一覧と追加',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalendarHomePage(),
    );
  }
}

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({super.key});

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  final CalendarApi _api = CalendarApi();
  List<CalendarEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionAndLoad();
  }

  Future<void> _checkPermissionAndLoad() async {
    final status = await Permission.calendar.status;
    if (!status.isGranted) {
      await Permission.calendar.request();
    }

    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final events = await _api.getCalendarEvents();
      setState(() {
        _events = events;
      });
    } on PlatformException catch (e) {
      debugPrint('エラー: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('カレンダー予定一覧')),
      body:
          _events.isEmpty
              ? const Center(child: Text('予定がありません'))
              : ListView.builder(
                itemCount: _events.length,

                itemBuilder: (context, index) {
                  final e = _events[index];

                  if (e.startTimeMillis == null || e.endTimeMillis == null) {
                    return const ListTile(title: Text('予定情報に不備があります'));
                  }

                  final start = DateTime.fromMillisecondsSinceEpoch(e.startTimeMillis!);
                  final end = DateTime.fromMillisecondsSinceEpoch(e.endTimeMillis!);

                  return ListTile(title: Text(e.title ?? ''), subtitle: Text('${start.toLocal()} - ${end.toLocal()}'));
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEventPage()));
          _loadEvents(); // 戻ってきたら再読み込み
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final CalendarApi _api = CalendarApi();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  String _status = '';

  Future<void> _pickDateTime(bool isStart) async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(now));

    if (pickedTime == null) return;

    final pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        _startDate = pickedDateTime;
      } else {
        _endDate = pickedDateTime;
      }
    });
  }

  Future<void> _addEvent() async {
    if (_startDate == null || _endDate == null) {
      setState(() => _status = '開始・終了日時を選択してください。');
      return;
    }

    final event = CalendarEvent(
      title: _titleController.text,
      description: _descController.text,
      location: _locationController.text,
      startTimeMillis: _startDate!.millisecondsSinceEpoch.toInt(),
      endTimeMillis: _endDate!.millisecondsSinceEpoch.toInt(),
    );

    try {
      await _api.addCalendarEvent(event);
      setState(() => _status = '予定を追加しました');
      Navigator.pop(context); // 一覧に戻る
    } on PlatformException catch (e) {
      setState(() => _status = 'エラー: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('予定を追加')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'タイトル')),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: '説明')),
            TextField(controller: _locationController, decoration: const InputDecoration(labelText: '場所')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _pickDateTime(true),
              child: Text(_startDate == null ? '開始日時を選択' : '開始: $_startDate'),
            ),
            ElevatedButton(
              onPressed: () => _pickDateTime(false),
              child: Text(_endDate == null ? '終了日時を選択' : '終了: $_endDate'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _addEvent, child: const Text('予定を追加')),
            const SizedBox(height: 16),
            Text(_status, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
