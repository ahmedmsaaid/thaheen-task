import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_assets.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/widgets/custom_toast_widget.dart';

class AppToast {
  AppToast._();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void hideAll() {
    scaffoldMessengerKey.currentState?.clearSnackBars();
  }

  static void showError(
    BuildContext? context, {
    required String message,
    String? subtitle,
  }) {
    final colors = context?.appColors ?? AppColors.light;
    final messenger = scaffoldMessengerKey.currentState ??
        (context != null ? ScaffoldMessenger.maybeOf(context) : null);
    messenger
      ?..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: AppDurations.snackBarDuration,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          padding: EdgeInsets.zero,
          content: CustomToastWidget(
            message: message,
            subtitle: subtitle,
            icon: Icons.error_outline_rounded,
            iconColor: colors.error,
          ),
        ),
      );
  }

  static void showSuccess(BuildContext? context, {required String message}) {
    final colors = context?.appColors ?? AppColors.light;
    final messenger = scaffoldMessengerKey.currentState ??
        (context != null ? ScaffoldMessenger.maybeOf(context) : null);
    messenger
      ?..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: AppDurations.snackBarDuration,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          padding: EdgeInsets.zero,
          content: CustomToastWidget(
            message: message,
            icon: Icons.check_circle_outline_rounded,
            iconColor: colors.success,
          ),
        ),
      );
  }
}
