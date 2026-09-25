import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/data/models/lesson_model.dart';

class NextLessonInfoColumn extends StatelessWidget {
  final LessonModel nextLesson;
  final bool onDarkBg;

  const NextLessonInfoColumn({super.key, required this.nextLesson, this.onDarkBg = false});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final labelColor = onDarkBg ? Colors.white.withValues(alpha: 0.75) : colors.primary;
    final titleColor = onDarkBg ? Colors.white : colors.textPrimary;
    final durationColor = onDarkBg ? Colors.white.withValues(alpha: 0.65) : colors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.nextLesson, style: AppTextStyles.caption(context).copyWith(color: labelColor, fontWeight: FontWeight.w700)),
        SizedBox(height: 2.h),
        Text(nextLesson.title, style: AppTextStyles.bodySemiBold(context).copyWith(color: titleColor), maxLines: 2, overflow: TextOverflow.ellipsis),
        SizedBox(height: 2.h),
        Text(nextLesson.formattedDuration, style: AppTextStyles.lessonDuration(context).copyWith(color: durationColor)),
      ],
    );
  }
}
