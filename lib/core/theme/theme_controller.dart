import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';

class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ref.read(themeLocalStorageProvider).getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(themeLocalStorageProvider).saveThemeMode(mode);
  }
}

final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeMode>(ThemeController.new);
