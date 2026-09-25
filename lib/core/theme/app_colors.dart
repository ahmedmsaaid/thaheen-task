import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors_dark.dart';
import 'package:thaheen/core/theme/app_colors_light.dart';

export 'package:thaheen/core/theme/app_colors_dark.dart';
export 'package:thaheen/core/theme/app_colors_light.dart';

/// ThemeExtension that holds resolved colors for current brightness.
class AppColors extends ThemeExtension<AppColors> {
  final bool isDark;

  const AppColors({this.isDark = false});

  static const light = AppColors(isDark: false);
  static const dark = AppColors(isDark: true);

  Color get primary => isDark ? AppColorsDark.primary : AppColorsLight.primary;
  Color get primaryDark => isDark ? AppColorsDark.primaryDark : AppColorsLight.primaryDark;
  Color get primaryDarkNavy => isDark ? AppColorsDark.primaryDarkNavy : AppColorsLight.primaryDarkNavy;
  Color get primaryLight => isDark ? AppColorsDark.primaryLight : AppColorsLight.primaryLight;
  Color get primaryTint => isDark ? AppColorsDark.primaryTint : AppColorsLight.primaryTint;
  Color get primaryTintSec => isDark ? AppColorsDark.primaryTintSec : AppColorsLight.primaryTintSec;
  Color get accentGold => isDark ? AppColorsDark.accentGold : AppColorsLight.accentGold;
  Color get success => isDark ? AppColorsDark.success : AppColorsLight.success;
  Color get warning => isDark ? AppColorsDark.warning : AppColorsLight.warning;
  Color get error => isDark ? AppColorsDark.error : AppColorsLight.error;
  Color get locked => isDark ? AppColorsDark.locked : AppColorsLight.locked;
  Color get background => isDark ? AppColorsDark.background : AppColorsLight.background;
  Color get surface => isDark ? AppColorsDark.surface : AppColorsLight.surface;
  Color get surfaceVariant => isDark ? AppColorsDark.surfaceVariant : AppColorsLight.surfaceVariant;
  Color get textPrimary => isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
  Color get textSecondary => isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary;
  Color get divider => isDark ? AppColorsDark.divider : AppColorsLight.divider;
  Color get circularUnSelectedContainerColor => isDark ? AppColorsDark.circularUnSelectedContainerColor : AppColorsLight.circularUnSelectedContainerColor;
  Color get circularSelectedContainerColor => isDark ? AppColorsDark.circularSelectedContainerColor : AppColorsLight.circularSelectedContainerColor;
  Color get unSelectedIconColor => isDark ? AppColorsDark.unSelectedIconColor : AppColorsLight.unSelectedIconColor;
  Color get overlay => isDark ? AppColorsDark.overlay : AppColorsLight.overlay;

  @override
  AppColors copyWith({bool? isDark}) => AppColors(isDark: isDark ?? this.isDark);

  @override
  AppColors lerp(AppColors? other, double t) => other == null ? this : (t < 0.5 ? this : other);
}

extension AppColorsExtension on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>() ?? AppColors.light;
}
