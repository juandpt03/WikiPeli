import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Colors.indigo;
  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(color: primaryColor));

  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.orange,
  );
}
