import 'package:flutter/material.dart';

import 'calendar_api.dart'; // pigeonで生成されたファイル

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String platformVersion = '取得中...';

  @override
  void initState() {
    super.initState();

    fetchPlatformVersion();
  }

  Future<void> fetchPlatformVersion() async {
    final api = CalendarApi();

    final version = await api.getPlatformVersion();

    setState(() {
      platformVersion = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('pigeon 動作確認')),
      body: Center(child: Text('プラットフォーム: $platformVersion')),
    );
  }
}
