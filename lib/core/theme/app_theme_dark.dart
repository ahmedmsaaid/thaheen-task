import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thaheen/core/theme/app_colors.dart';

ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      secondary: AppColorsDark.accentGold,
      surface: AppColorsDark.surface,
      error: AppColorsDark.error,
      onPrimary: Colors.white,
      onSurface: AppColorsDark.textPrimary,
    ),
    textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: AppColorsDark.textPrimary,
      displayColor: AppColorsDark.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsDark.surface,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColorsDark.textPrimary),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColorsDark.surface,
      elevation: 2,
      shadowColor: AppColorsDark.primary.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColorsDark.divider,
      thickness: 1,
    ),
    extensions: const [AppColors.dark],
  );
}
