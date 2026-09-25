import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_actions.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/playlist_lesson_tile.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/playlist_section_header.dart';

class CourseLessonsPlaylistTab extends ConsumerWidget {
  final CourseModel course;
  final String activeLessonId;
  final LessonPlayerActions act;

  const CourseLessonsPlaylistTab({
    super.key,
    required this.course,
    required this.activeLessonId,
    required this.act,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressRepo = ref.watch(progressRepositoryProvider);
    final progressMap = progressRepo.getCourseProgress(course.id);
    final unlockPolicy = ref.watch(unlockPolicyProvider);
    final allLessons = course.allLessons;

    var globalLessonIndex = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final section in course.sections) ...[
          PlaylistSectionHeader(
            title: section.title,
            lessonsCount: section.lessons.length,
          ),
          ...section.lessons.map((lesson) {
            globalLessonIndex++;
            final displayIndex = globalLessonIndex;
            final isActive = lesson.id == activeLessonId;
            final isUnlocked = unlockPolicy.isLessonUnlocked(
              lesson: lesson,
              allLessons: allLessons,
              progressMap: progressMap,
            );
            final progress = progressMap[lesson.id];
            final isCompleted = progress?.isCompleted == true;

            return PlaylistLessonTile(
              lesson: lesson,
              displayIndex: displayIndex,
              isActive: isActive,
              isUnlocked: isUnlocked,
              isCompleted: isCompleted,
              act: act,
            );
          }),
          SizedBox(height: 12.h),
        ],
      ],
    );
  }
}
