import 'package:flutter/material.dart';

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF20232a),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStatePropertyAll(Color(0xFFf79415)),
      iconSize: WidgetStatePropertyAll(32.0),
    ),
  ),
);
