import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_state.dart';

class ProgressCourseTile extends StatelessWidget {
  final CourseViewModel viewModel;

  const ProgressCourseTile({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final course = viewModel.course;
    final pct = (viewModel.progressRatio * 100).toInt();

    return GestureDetector(
      onTap: () => context.push(AppRouter.courseDetailsPath(course.id)),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(course.title, style: AppTextStyles.h3(context))),
                Text('$pct%', style: AppTextStyles.bodySemiBold(context).copyWith(color: colors.primary)),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              '${viewModel.completedLessons} / ${course.totalLessons} ${AppStrings.lessonsCount}',
              style: AppTextStyles.caption(context),
            ),
            SizedBox(height: 10.h),
            LinearProgressIndicator(
              value: viewModel.progressRatio,
              backgroundColor: colors.surfaceVariant,
              color: viewModel.isFullyCompleted ? colors.success : colors.primary,
              borderRadius: BorderRadius.circular(8.r),
              minHeight: 6.h,
            ),
          ],
        ),
      ),
    );
  }
}
