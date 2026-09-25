import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_theme_dark.dart';
import 'package:thaheen/core/theme/app_theme_light.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => buildLightTheme();
  static ThemeData get darkTheme => buildDarkTheme();
}
