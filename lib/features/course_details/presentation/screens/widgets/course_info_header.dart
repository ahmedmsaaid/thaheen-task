import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_progress_bar.dart';

class CourseInfoHeader extends StatelessWidget {
  final Course course;
  final double progressPercentage;
  final int completedLessons;

  const CourseInfoHeader({
    super.key,
    required this.course,
    required this.progressPercentage,
    required this.completedLessons,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [BoxShadow(color: colors.primary.withValues(alpha: 0.06), blurRadius: 12.r, offset: Offset(0, 4.h))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.title, style: AppTextStyles.h1(context)),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.person_outline_rounded, size: 16.sp, color: colors.textSecondary),
              SizedBox(width: 6.w),
              Text(course.instructor, style: AppTextStyles.bodySecondary(context)),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w.w, vertical: 4.h.h),
                decoration: BoxDecoration(color: colors.primaryTint, borderRadius: BorderRadius.circular(20.r)),
                child: Text('${course.totalLessons} ${AppStrings.lessonsCount}',
                    style: AppTextStyles.caption(context).copyWith(color: colors.primary, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          if (progressPercentage > 0) ...[
            SizedBox(height: 14.h),
            CourseProgressBar(progress: progressPercentage, completedLessons: completedLessons, totalLessons: course.totalLessons),
          ],
        ],
      ),
    );
  }
}
