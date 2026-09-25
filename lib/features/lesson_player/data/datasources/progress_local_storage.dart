import 'package:hive_flutter/hive_flutter.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';

class ProgressLocalStorage {
  static const _boxName = 'lesson_progress';

  static Future<void> openBox() async {
    await Hive.openBox<LessonProgressModel>(_boxName);
  }

  Box<LessonProgressModel> get _box =>
      Hive.box<LessonProgressModel>(_boxName);

  Future<void> saveProgress(LessonProgressModel progress) async {
    final key = LessonProgressModel.hiveKey(
      progress.courseId,
      progress.lessonId,
    );
    await _box.put(key, progress);
  }

  LessonProgressModel? getProgress(String courseId, String lessonId) {
    return _box.get(LessonProgressModel.hiveKey(courseId, lessonId));
  }

  Map<String, LessonProgressModel> getCourseProgress(String courseId) {
    final result = <String, LessonProgressModel>{};
    for (final entry in _box.toMap().entries) {
      if (entry.value.courseId == courseId) {
        result[entry.value.lessonId] = entry.value;
      }
    }
    return result;
  }

  LessonProgressModel? getLastWatchedIncomplete() {
    LessonProgressModel? latest;
    for (final progress in _box.values) {
      if (!progress.isCompleted && progress.watchedSeconds > 0) {
        if (latest == null ||
            progress.lastWatched.isAfter(latest.lastWatched)) {
          latest = progress;
        }
      }
    }
    return latest;
  }

  LessonProgressModel? getLatestWatched() {
    LessonProgressModel? latest;
    for (final progress in _box.values) {
      if (progress.watchedSeconds > 0 || progress.isCompleted) {
        if (latest == null ||
            progress.lastWatched.isAfter(latest.lastWatched)) {
          latest = progress;
        }
      }
    }
    return latest;
  }
}
