import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_progress_bar.dart';

class CourseCardContent extends StatelessWidget {
  final CourseViewModel viewModel;

  const CourseCardContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final course = viewModel.course;
    final progress = viewModel.progressPercentage;

    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.title, style: AppTextStyles.h3(context), maxLines: 2, overflow: TextOverflow.ellipsis),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.person_outline_rounded, size: 14.sp, color: colors.textSecondary),
              SizedBox(width: 4.w),
              Expanded(child: Text(course.instructor, style: AppTextStyles.caption(context), maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
          SizedBox(height: 10.h),
          if (progress > 0)
            CourseProgressBar(progress: progress, completedLessons: viewModel.completedLessons, totalLessons: course.totalLessons)
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w.w, vertical: 4.h.h),
              decoration: BoxDecoration(color: colors.primaryTint, borderRadius: BorderRadius.circular(20.r)),
              child: Text(AppStrings.lessonStatusNotStarted, style: AppTextStyles.caption(context).copyWith(color: colors.primary, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }
}
