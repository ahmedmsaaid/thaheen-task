import 'package:thaheen/features/lesson_player/data/datasources/progress_local_storage.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';
import 'package:thaheen/features/lesson_player/domain/repos/progress_repo_interface.dart';

class ProgressRepository implements ProgressRepoInterface {
  final ProgressLocalStorage _storage;
  const ProgressRepository(this._storage);

  @override
  LessonProgressModel? getProgress(String courseId, String lessonId) =>
      _storage.getProgress(courseId, lessonId);

  @override
  Map<String, LessonProgressModel> getCourseProgress(String courseId) =>
      _storage.getCourseProgress(courseId);

  @override
  Future<void> saveWatchPosition({
    required String courseId,
    required String lessonId,
    required int watchedSeconds,
    required bool isCompleted,
  }) async {
    final existing = _storage.getProgress(courseId, lessonId);
    final progress = LessonProgressModel(
      lessonId: lessonId,
      courseId: courseId,
      watchedSeconds: watchedSeconds,
      isCompleted: isCompleted || (existing?.isCompleted ?? false),
      lastWatched: DateTime.now(),
    );
    await _storage.saveProgress(progress);
  }

  @override
  Future<void> markCompleted(
    String courseId,
    String lessonId, {
    int watchedSeconds = 0,
  }) async {
    final existing = _storage.getProgress(courseId, lessonId);
    final progress = LessonProgressModel(
      lessonId: lessonId,
      courseId: courseId,
      watchedSeconds: watchedSeconds > 0
          ? watchedSeconds
          : (existing?.watchedSeconds ?? 0),
      isCompleted: true,
      lastWatched: DateTime.now(),
    );
    await _storage.saveProgress(progress);
  }

  @override
  LessonProgressModel? getLastWatchedIncomplete() =>
      _storage.getLastWatchedIncomplete();

  @override
  LessonProgressModel? getLatestWatched() =>
      _storage.getLatestWatched();
}
