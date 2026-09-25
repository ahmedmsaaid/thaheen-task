import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_session_state.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/next_lesson_prompt_data.dart';

class BetterPlayerProgressSaver {
  const BetterPlayerProgressSaver._();

  static Future<void> save({
    required Ref ref,
    required BetterPlayerSessionState session,
    required BetterPlayerController? controller,
    bool isFinished = false,
  }) async {
    final cId = session.currentCourseId;
    final lId = session.currentLessonId;
    if (cId == null || lId == null) return;
    final pos = controller?.videoPlayerController?.value.position.inSeconds ?? 0;
    final total = controller?.videoPlayerController?.value.duration?.inSeconds ?? 0;
    if (total <= 0 && !isFinished) return;
    try {
      final calc = ref.read(progressCalculatorProvider);
      final isDone = isFinished || calc.isCompleted(watchedSeconds: pos, totalSeconds: total);
      final repo = ref.read(progressRepositoryProvider);
      final cur = repo.getProgress(cId, lId);
      final isComp = isDone || (cur?.isCompleted ?? false);
      await repo.saveWatchPosition(
        courseId: cId,
        lessonId: lId,
        watchedSeconds: isFinished ? total : pos,
        isCompleted: isComp,
      );
      ref.read(coursesControllerProvider.notifier).loadCourses();
    } catch (_) {}
  }

  static Future<NextLessonPromptData?> checkNextPrompt({
    required Ref ref,
    required BetterPlayerSessionState session,
  }) async {
    final cId = session.currentCourseId;
    final lId = session.currentLessonId;
    if (cId == null || lId == null) return null;
    try {
      final course = await ref.read(coursesRepositoryProvider).fetchCourse(cId);
      final lessons = course.allLessons;
      final idx = lessons.indexWhere((l) => l.id == lId);
      if (idx != -1 && idx + 1 < lessons.length) {
        return NextLessonPromptData(
          courseId: cId,
          completedLesson: lessons[idx],
          nextLesson: lessons[idx + 1],
        );
      }
    } catch (_) {}
    return null;
  }
}
