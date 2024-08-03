import 'package:flutter/material.dart';
import 'package:flutter_stopwatch/stopwatch_page.dart';
import 'package:flutter_stopwatch/util/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stopwatch',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            title: const Text("Flutter Stopwatch"),
          ),
          body: const StopwatchPage(),
        ),
      ),
    );
  }
}
