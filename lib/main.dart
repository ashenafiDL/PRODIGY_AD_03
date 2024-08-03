import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor:
                darkTheme.scaffoldBackgroundColor, // Navigation bar
            statusBarColor: darkTheme.scaffoldBackgroundColor, // Status bar
          ),
          title: const Text("Flutter Stopwatch"),
        ),
        body: const StopwatchPage(),
      ),
    );
  }
}
