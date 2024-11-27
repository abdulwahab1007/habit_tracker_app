import 'package:flutter/material.dart';

ThemeData darkMode=ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: const Color.fromARGB(255, 25, 25, 25),
    primary: Colors.grey.shade600,
    secondary: const Color.fromARGB(255, 62, 62, 62),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300
  )
  );