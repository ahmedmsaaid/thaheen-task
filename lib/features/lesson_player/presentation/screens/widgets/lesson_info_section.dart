import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_actions.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_info_header_badges.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_info_metadata_row.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_quick_actions_bar.dart';

class LessonInfoSection extends StatelessWidget {
  final LessonModel lesson;
  final CourseModel course;
  final bool isCompleted;
  final double currentSpeed;
  final BetterPlayerService service;
  final LessonPlayerActions act;

  const LessonInfoSection({
    super.key,
    required this.lesson,
    required this.course,
    required this.isCompleted,
    required this.currentSpeed,
    required this.service,
    required this.act,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final allLessons = course.allLessons;
    final currentIndex = allLessons.indexWhere((l) => l.id == lesson.id) + 1;

    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: Offset(0.w, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LessonInfoHeaderBadges(
            currentIndex: currentIndex,
            totalLessons: allLessons.length,
            isCompleted: isCompleted,
          ),
          SizedBox(height: 12.h),
          Text(
            lesson.title,
            style: AppTextStyles.h2(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8.h),
          LessonInfoMetadataRow(
            formattedDuration: lesson.formattedDuration,
            instructor: course.instructor,
          ),
          SizedBox(height: 14.h),
          const Divider(height: 1),
          SizedBox(height: 12.h),
          LessonQuickActionsBar(
            currentSpeed: currentSpeed,
            service: service,
            act: act,
            hasNextLesson: act.nextLessonId != null,
          ),
        ],
      ),
    );
  }
}
