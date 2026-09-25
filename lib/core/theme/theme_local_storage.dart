import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeLocalStorage {
  static const _boxName = 'app_settings';
  static const _themeKey = 'theme_mode';

  static Future<void> openBox() async {
    await Hive.openBox<String>(_boxName);
  }

  Box<String> get _box => Hive.box<String>(_boxName);

  ThemeMode getThemeMode() {
    final val = _box.get(_themeKey, defaultValue: 'system');
    switch (val) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final str = mode == ThemeMode.light
        ? 'light'
        : (mode == ThemeMode.dark ? 'dark' : 'system');
    await _box.put(_themeKey, str);
  }
}
