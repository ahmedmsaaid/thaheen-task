import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/data/models/lesson_model.dart';

class NextLessonPromptPreviewCard extends StatelessWidget {
  final Lesson nextLesson;
  final VoidCallback? onTap;

  const NextLessonPromptPreviewCard({
    super.key,
    required this.nextLesson,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.play_circle_fill_rounded, color: colors.primary, size: 32.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nextLesson.title,
                  style: AppTextStyles.h3(context).copyWith(fontSize: 14.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  nextLesson.formattedDuration,
                  style: AppTextStyles.caption(context).copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
