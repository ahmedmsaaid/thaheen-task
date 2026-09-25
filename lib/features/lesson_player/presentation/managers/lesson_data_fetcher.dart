import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_state.dart';

Future<PlayerDataInternal> fetchPlayerData(
  Ref ref,
  LessonPlayerArgs arg,
) async {
  final crs = await ref.read(coursesRepositoryProvider).fetchCourse(arg.courseId);
  final all = crs.allLessons;
  final cur = all.firstWhere((l) => l.id == arg.lessonId);
  final pMap = ref.read(progressRepositoryProvider).getCourseProgress(arg.courseId);
  final nxt = ref.read(unlockPolicyProvider).findNextLesson(currentLessonId: arg.lessonId, allLessons: all);
  final saved = ref.read(progressRepositoryProvider).getProgress(arg.courseId, arg.lessonId);
  final isDone = saved?.isCompleted ?? false;
  final watched = saved?.watchedSeconds ?? 0;
  final isNearEnd = cur.durationSec > 0 && watched >= (cur.durationSec - 2);
  final resume = isNearEnd ? 0 : watched;
  final unlocked = (nxt != null &&
          (isDone || ref.read(unlockPolicyProvider).isLessonUnlocked(lesson: nxt, allLessons: all, progressMap: pMap)))
      ? nxt
      : null;
  return PlayerDataInternal(
    course: crs,
    currentLesson: cur,
    nextLesson: unlocked,
    resumeFromSeconds: resume,
  );
}
