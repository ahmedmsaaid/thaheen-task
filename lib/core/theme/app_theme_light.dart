import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thaheen/core/theme/app_colors.dart';

ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.background,
    colorScheme: const ColorScheme.light(
      primary: AppColorsLight.primary,
      secondary: AppColorsLight.accentGold,
      surface: AppColorsLight.surface,
      error: AppColorsLight.error,
      onPrimary: Colors.white,
      onSurface: AppColorsLight.textPrimary,
    ),
    textTheme: GoogleFonts.cairoTextTheme().apply(
      bodyColor: AppColorsLight.textPrimary,
      displayColor: AppColorsLight.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColorsLight.surface,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColorsLight.textPrimary),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColorsLight.surface,
      elevation: 2,
      shadowColor: AppColorsLight.primary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColorsLight.divider,
      thickness: 1,
    ),
    extensions: const [AppColors.light],
  );
}
