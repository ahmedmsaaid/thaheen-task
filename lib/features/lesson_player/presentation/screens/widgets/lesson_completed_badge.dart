import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class LessonCompletedBadge extends StatelessWidget {
  const LessonCompletedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.success.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, color: colors.success, size: 16),
          SizedBox(width: 4.w),
          Text(AppStrings.lessonStatusCompleted,
              style: AppTextStyles.success(context)),
        ],
      ),
    );
  }
}
