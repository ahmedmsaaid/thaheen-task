import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class LessonInfoHeaderBadges extends StatelessWidget {
  final int currentIndex;
  final int totalLessons;
  final bool isCompleted;

  const LessonInfoHeaderBadges({
    super.key,
    required this.currentIndex,
    required this.totalLessons,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_lesson_rounded, size: 14, color: colors.primary),
              SizedBox(width: 4.w),
              Text(
                '${PlayerStrings.lessonPrefix} $currentIndex ${PlayerStrings.ofTotal} $totalLessons',
                style: AppTextStyles.captionBold(context).copyWith(
                  color: colors.primary,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isCompleted
                ? colors.success.withValues(alpha: 0.12)
                : colors.warning.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.timelapse_rounded,
                size: 14,
                color: isCompleted ? colors.success : colors.warning,
              ),
              SizedBox(width: 4.w),
              Text(
                isCompleted ? PlayerStrings.completed : PlayerStrings.inProgress,
                style: AppTextStyles.captionBold(context).copyWith(
                  color: isCompleted ? colors.success : colors.warning,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
