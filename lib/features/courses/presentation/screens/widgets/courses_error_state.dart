import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CoursesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CoursesErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: colors.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.wifi_off_rounded, size: 48, color: colors.error),
            ),
            SizedBox(height: 20.h),
            Text(AppStrings.coursesLoadError, style: AppTextStyles.h3(context), textAlign: TextAlign.center),
            SizedBox(height: 8.h),
            Text(message, style: AppTextStyles.bodySecondary(context), textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(AppStrings.retryButton),
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
