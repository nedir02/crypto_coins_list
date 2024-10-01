import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    listTileTheme: const ListTileThemeData(iconColor: Colors.white),
    dividerColor: Colors.white24,
    textTheme: TextTheme(
        bodyMedium: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        labelSmall: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w700,
            fontSize: 20),
        headlineMedium: const TextStyle(color: Colors.white)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 31, 31, 31),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.yellow, backgroundColor: Colors.grey));
