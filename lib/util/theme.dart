import 'package:flutter/material.dart';

const seedColor = Colors.blue;
const useMaterial3 = true;

var lightTheme = ThemeData(
  // colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  brightness: Brightness.light,
  useMaterial3: useMaterial3,
);

var darkTheme = ThemeData(
  // colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
  brightness: Brightness.dark,
  useMaterial3: useMaterial3,
);
