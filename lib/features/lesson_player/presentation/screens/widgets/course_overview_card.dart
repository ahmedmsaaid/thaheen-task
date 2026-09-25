import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/course_stat_item.dart';

class CourseOverviewCard extends StatelessWidget {
  final CourseModel course;

  const CourseOverviewCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
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
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  course.thumbnail,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 70,
                    height: 70,
                    color: colors.surfaceVariant,
                    child: Icon(Icons.menu_book_rounded, color: colors.primary),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: AppTextStyles.h3(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.person_pin_rounded,
                            size: 16, color: colors.primary),
                        SizedBox(width: 4.w),
                        Text(
                          course.instructor,
                          style: AppTextStyles.captionBold(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CourseStatItem(
                icon: Icons.video_library_rounded,
                value: '${course.totalLessons}',
                label: PlayerStrings.totalLessonsLabel,
              ),
              CourseStatItem(
                icon: Icons.layers_rounded,
                value: '${course.totalSections}',
                label: PlayerStrings.sectionsLabel,
              ),
               CourseStatItem(
                icon: Icons.verified_rounded,
                value: PlayerStrings.certificateLabel,
                label: PlayerStrings.onCompletionLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
