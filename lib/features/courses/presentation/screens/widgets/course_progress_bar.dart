import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CourseProgressBar extends StatelessWidget {
  final double progress;
  final int completedLessons;
  final int totalLessons;

  const CourseProgressBar({
    super.key,
    required this.progress,
    required this.completedLessons,
    required this.totalLessons,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$completedLessons/$totalLessons ${AppStrings.lessonsCount}', style: AppTextStyles.caption(context)),
            Text('${(progress * 100).toInt()}%', style: AppTextStyles.captionBold(context).copyWith(color: colors.primary)),
          ],
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6.h,
            backgroundColor: colors.primaryTintSec,
            valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
          ),
        ),
      ],
    );
  }
}
