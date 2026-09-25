import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_thumbnail.dart';
import 'package:thaheen/features/watched_courses/presentation/screens/widgets/watched_card_progress.dart';

class WatchedCourseCard extends StatelessWidget {
  final CourseViewModel viewModel;
  const WatchedCourseCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final course = viewModel.course;

    return GestureDetector(
      onTap: () => context.push(AppRouter.courseDetailsPath(course.id)),
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [BoxShadow(color: colors.isDark ? Colors.black26 : colors.primary.withValues(alpha: 0.07), blurRadius: 12.r, offset: Offset(0, 4.h))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(18.r)),
              child: SizedBox(width: 96.w, height: 96.h, child: CourseThumbnail(imagePath: course.thumbnail)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title, style: AppTextStyles.h3(context), maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4.h),
                    Text(course.instructor, style: AppTextStyles.caption(context), maxLines: 1),
                    SizedBox(height: 10.h),
                    WatchedCardProgress(ratio: viewModel.progressRatio, isCompleted: viewModel.isFullyCompleted),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
