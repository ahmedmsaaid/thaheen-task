import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CourseDetailsErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CourseDetailsErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 56, color: colors.error),
          SizedBox(height: 16.h),
          Text(AppStrings.coursesLoadError, style: AppTextStyles.h3(context)),
          SizedBox(height: 8.h),
          Text(message, style: AppTextStyles.bodySecondary(context)),
          SizedBox(height: 20.h),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(AppStrings.retryButton),
          ),
        ],
      ),
    );
  }
}
