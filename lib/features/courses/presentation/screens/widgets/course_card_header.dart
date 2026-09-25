import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_info_badge.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_thumbnail.dart';

class CourseCardHeader extends StatelessWidget {
  final Course course;
  const CourseCardHeader({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          child: CourseThumbnail(imagePath: course.thumbnail),
        ),
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, colors.primaryDarkNavy.withValues(alpha: 0.88)],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12.h, right: 14.w, left: 14.w,
          child: Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            children: [
              CourseInfoBadge(icon: Icons.play_lesson_rounded, label: '${course.totalLessons} ${AppStrings.lessonsCount}'),
              CourseInfoBadge(icon: Icons.folder_outlined, label: '${course.totalSections} ${AppStrings.sectionCount}'),
            ],
          ),
        ),
      ],
    );
  }
}
