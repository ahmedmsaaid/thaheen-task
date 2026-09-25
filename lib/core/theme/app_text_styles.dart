import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thaheen/core/theme/app_colors.dart';

/// Centralized text styles — all text in the app must come from here.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _style(double size, FontWeight weight, Color color, [double? height]) =>
      GoogleFonts.cairo(fontSize: size.sp, fontWeight: weight, color: color, height: height);

  static TextStyle heroTitle(BuildContext c) => _style(26, FontWeight.w800, c.appColors.textPrimary, 1.3);
  static TextStyle h1(BuildContext c) => _style(22, FontWeight.bold, c.appColors.textPrimary, 1.35);
  static TextStyle h2(BuildContext c) => _style(18, FontWeight.w700, c.appColors.textPrimary, 1.35);
  static TextStyle h3(BuildContext c) => _style(16, FontWeight.w600, c.appColors.textPrimary, 1.4);
  static TextStyle bodyPrimary(BuildContext c) => _style(15, FontWeight.w400, c.appColors.textPrimary, 1.5);
  static TextStyle bodySecondary(BuildContext c) => _style(14, FontWeight.w400, c.appColors.textSecondary, 1.5);
  static TextStyle bodyLocked(BuildContext c) => _style(14, FontWeight.w400, c.appColors.locked, 1.5);
  static TextStyle bodySemiBold(BuildContext c) => _style(15, FontWeight.w600, c.appColors.textPrimary, 1.4);
  static TextStyle caption(BuildContext c) => _style(12, FontWeight.w400, c.appColors.textSecondary, 1.4);
  static TextStyle captionBold(BuildContext c) => _style(12, FontWeight.w700, c.appColors.textSecondary, 1.4);
  static TextStyle buttonPrimary(BuildContext c) => _style(15, FontWeight.w700, Colors.white, 1.2);
  static TextStyle success(BuildContext c) => _style(13, FontWeight.w600, c.appColors.success);
  static TextStyle error(BuildContext c) => _style(13, FontWeight.w500, c.appColors.error);
  static TextStyle cardOverlay(BuildContext c) => _style(14, FontWeight.w700, Colors.white, 1.4);
  static TextStyle priceGreen(BuildContext c) => _style(16, FontWeight.w700, c.appColors.success);
  static TextStyle lessonDuration(BuildContext c) => _style(12, FontWeight.w500, c.appColors.textSecondary);
  static TextStyle sectionTitle(BuildContext c) => _style(15, FontWeight.w700, c.appColors.textPrimary, 1.3);
}
