import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_state.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';

ContinueWatchingViewModel? findContinueWatching(
  List<Course> courses,
  LessonProgressModel? last, {
  String? activeCourseId,
  String? activeLessonId,
}) {
  if (courses.isEmpty) return null;

  if (activeCourseId != null && activeLessonId != null) {
    for (final c in courses) {
      if (c.id == activeCourseId) {
        final l = c.allLessons.where((x) => x.id == activeLessonId).firstOrNull;
        if (l != null) {
          return ContinueWatchingViewModel(
            course: c,
            lesson: l,
            progress: last ??
                LessonProgressModel(
                  courseId: c.id,
                  lessonId: l.id,
                  watchedSeconds: 0,
                  isCompleted: false,
                  lastWatched: DateTime.now(),
                ),
          );
        }
      }
    }
  }

  if (last != null) {
    for (final c in courses) {
      final lessons = c.allLessons;
      final idx = lessons.indexWhere((x) => x.id == last.lessonId);
      if (idx != -1) {
        if (last.isCompleted && idx + 1 < lessons.length) {
          final nextLesson = lessons[idx + 1];
          return ContinueWatchingViewModel(
            course: c,
            lesson: nextLesson,
            progress: LessonProgressModel(
              courseId: c.id,
              lessonId: nextLesson.id,
              watchedSeconds: 0,
              isCompleted: false,
              lastWatched: last.lastWatched,
            ),
          );
        }
        return ContinueWatchingViewModel(
          course: c,
          lesson: lessons[idx],
          progress: last,
        );
      }
    }
  }

  final firstCourse = courses.firstOrNull;
  final firstLesson = firstCourse?.allLessons.firstOrNull;
  if (firstCourse != null && firstLesson != null) {
    return ContinueWatchingViewModel(
      course: firstCourse,
      lesson: firstLesson,
      progress: LessonProgressModel(
        courseId: firstCourse.id,
        lessonId: firstLesson.id,
        watchedSeconds: 0,
        isCompleted: false,
        lastWatched: DateTime.now(),
      ),
    );
  }

  return null;
}
