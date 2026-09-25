import 'package:thaheen/features/courses/data/models/lesson_model.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';

class UnlockPolicy {
  const UnlockPolicy();

  bool isLessonUnlocked({
    required LessonModel lesson,
    required List<LessonModel> allLessons,
    required Map<String, LessonProgressModel> progressMap,
  }) {
    final index = allLessons.indexWhere((l) => l.id == lesson.id);
    if (index < 0) return false;
    if (index == 0) return true;
    final previousLesson = allLessons[index - 1];
    final previousProgress = progressMap[previousLesson.id];
    return previousProgress?.isCompleted == true;
  }

  LessonModel? findResumeLesson({
    required List<LessonModel> allLessons,
    required Map<String, LessonProgressModel> progressMap,
  }) {
    for (final lesson in allLessons) {
      final progress = progressMap[lesson.id];
      if (progress != null &&
          !progress.isCompleted &&
          progress.watchedSeconds > 0) {
        return lesson;
      }
    }
    return null;
  }

  LessonModel? findNextLesson({
    required String currentLessonId,
    required List<LessonModel> allLessons,
  }) {
    final index = allLessons.indexWhere((l) => l.id == currentLessonId);
    if (index < 0 || index >= allLessons.length - 1) return null;
    return allLessons[index + 1];
  }
}
