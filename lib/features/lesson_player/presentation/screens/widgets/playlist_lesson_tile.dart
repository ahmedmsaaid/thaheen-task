import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/locked_lesson_sheet.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_actions.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/playlist_lesson_tile_leading.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/playlist_lesson_tile_subtitle.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/playlist_lesson_tile_trailing.dart';

class PlaylistLessonTile extends StatelessWidget {
  final Lesson lesson;
  final int displayIndex;
  final bool isActive;
  final bool isUnlocked;
  final bool isCompleted;
  final LessonPlayerActions act;

  const PlaylistLessonTile({
    super.key,
    required this.lesson,
    required this.displayIndex,
    required this.isActive,
    required this.isUnlocked,
    required this.isCompleted,
    required this.act,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isActive
            ? colors.primary.withValues(alpha: 0.08)
            : isUnlocked
                ? colors.surface
                : colors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isActive
              ? colors.primary
              : isCompleted
                  ? colors.success.withValues(alpha: 0.35)
                  : isUnlocked
                      ? colors.divider
                      : colors.divider.withValues(alpha: 0.5),
          width: isActive ? 1.5 : 1.0,
        ),
      ),
      child: ListTile(
        onTap: () {
          if (isUnlocked) {
            act.goToLesson(context, lesson.id);
          } else {
            LockedLessonSheet.show(context, lesson.title);
          }
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
        leading: PlaylistLessonTileLeading(
          displayIndex: displayIndex,
          isActive: isActive,
          isUnlocked: isUnlocked,
          isCompleted: isCompleted,
        ),
        title: Text(
          lesson.title,
          style: isUnlocked
              ? AppTextStyles.bodySemiBold(context).copyWith(
                  color: isActive ? colors.primary : colors.textPrimary,
                  fontSize: 14,
                )
              : AppTextStyles.bodyLocked(context).copyWith(fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: PlaylistLessonTileSubtitle(
          duration: lesson.formattedDuration,
          isUnlocked: isUnlocked,
          isCompleted: isCompleted,
        ),
        trailing: PlaylistLessonTileTrailing(
          isActive: isActive,
          isUnlocked: isUnlocked,
          isCompleted: isCompleted,
        ),
      ),
    );
  }
}
