import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/course_details/presentation/managers/course_details_controller.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/in_progress_badge.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/lesson_status_icon.dart';

class LessonListItem extends StatelessWidget {
  final LessonViewModel lessonVM;
  final VoidCallback onTap;

  const LessonListItem({super.key, required this.lessonVM, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final lesson = lessonVM.lesson;
    final isLocked = lessonVM.isLocked;

    return Semantics(
      label: isLocked ? AppStrings.lockedLessonLabel : (lessonVM.isCompleted ? AppStrings.completedLessonLabel : AppStrings.inProgressLessonLabel),
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w.w, vertical: 10.h.h),
          child: Row(
            children: [
              LessonStatusIcon(status: lessonVM.status),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lesson.title, style: isLocked ? AppTextStyles.bodyLocked(context) : AppTextStyles.bodyPrimary(context), maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 12.sp, color: isLocked ? colors.locked : colors.textSecondary),
                        SizedBox(width: 3.w),
                        Text(lesson.formattedDuration, style: AppTextStyles.lessonDuration(context).copyWith(color: isLocked ? colors.locked : colors.textSecondary)),
                        if (lessonVM.status == LessonStatus.inProgress) ...[SizedBox(width: 8.w), const InProgressBadge()],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(isLocked ? Icons.lock_outline_rounded : Icons.play_circle_outline_rounded, size: isLocked ? 16.sp : 20.sp, color: isLocked ? colors.locked : colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
