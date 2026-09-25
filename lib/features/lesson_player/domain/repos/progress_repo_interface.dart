import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';

abstract class ProgressRepoInterface {
  LessonProgressModel? getProgress(String courseId, String lessonId);
  Map<String, LessonProgressModel> getCourseProgress(String courseId);
  Future<void> saveWatchPosition({
    required String courseId,
    required String lessonId,
    required int watchedSeconds,
    required bool isCompleted,
  });
  Future<void> markCompleted(
    String courseId,
    String lessonId, {
    int watchedSeconds = 0,
  });
  LessonProgressModel? getLastWatchedIncomplete();
  LessonProgressModel? getLatestWatched();
}
