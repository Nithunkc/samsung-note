import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.white,
        primary: const Color.fromARGB(255, 230, 229, 229),
        secondary: const Color.fromARGB(255, 186, 186, 186)));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Colors.black,
        primary: const Color.fromARGB(255, 25, 25, 25),
        secondary: const Color.fromARGB(255, 69, 69, 69)));