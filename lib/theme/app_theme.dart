import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Color(0xFF6200EE), // Primary Color
      colorScheme: ColorScheme(
        primary: Color(0xFF6200EE),
        primaryVariant: Color(0xFF3700B3),
        secondary: Color(0xFF03DAC6),
        secondaryVariant: Color(0xFF018786),
        surface: Colors.white,
        background: Colors.white,
        error: Color(0xFFB00020),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      typography: Typography.material2018(), // Default typography
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      // Additional theme settings can be added here
    );
  }
}