import 'package:hive/hive.dart';

part 'lesson_progress_model.g.dart';

@HiveType(typeId: 0)
class LessonProgressModel extends HiveObject {
  @HiveField(0)
  final String lessonId;

  @HiveField(1)
  final String courseId;

  @HiveField(2)
  final int watchedSeconds;

  @HiveField(3)
  final bool isCompleted;

  @HiveField(4)
  final DateTime lastWatched;

  LessonProgressModel({
    required this.lessonId,
    required this.courseId,
    required this.watchedSeconds,
    required this.isCompleted,
    required this.lastWatched,
  });

  LessonProgressModel copyWith({
    String? lessonId,
    String? courseId,
    int? watchedSeconds,
    bool? isCompleted,
    DateTime? lastWatched,
  }) {
    return LessonProgressModel(
      lessonId: lessonId ?? this.lessonId,
      courseId: courseId ?? this.courseId,
      watchedSeconds: watchedSeconds ?? this.watchedSeconds,
      isCompleted: isCompleted ?? this.isCompleted,
      lastWatched: lastWatched ?? this.lastWatched,
    );
  }

  static String hiveKey(String courseId, String lessonId) =>
      '${courseId}_$lessonId';
}
