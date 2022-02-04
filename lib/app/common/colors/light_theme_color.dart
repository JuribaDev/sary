import 'package:flutter/material.dart';

const scaffoldBackgroundColor = Color(0xffF8F8F8);
final ColorScheme lightColorScheme = ColorScheme.fromSwatch().copyWith(
  primary: const Color(0xFF5044B8),
  primaryContainer: const Color(0xFF5044B8),
  secondary: const Color(0xFF5044B8),
  secondaryContainer: const Color(0xFF5044B8),
  surface: const Color(0xffF8F8F8),
  background: const Color(0xffF8F8F8),
  error: const Color(0xffF8F8F8),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
);
