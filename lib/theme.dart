import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffdadbdd),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffdadbdd),
    elevation: 0,
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white70)),
);
