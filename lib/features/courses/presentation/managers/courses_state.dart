import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';

class CourseViewModel {
  final Course course;
  final int completedLessons;
  final double progressRatio;
  final bool hasStarted;

  const CourseViewModel({
    required this.course,
    required this.completedLessons,
    required this.progressRatio,
    this.hasStarted = false,
  });

  bool get isFullyCompleted => progressRatio >= 1.0;
  bool get isStarted => hasStarted || completedLessons > 0 || progressRatio > 0;
  double get progressPercentage => progressRatio;
}

class ContinueWatchingViewModel {
  final Course course;
  final Lesson lesson;
  final LessonProgressModel progress;

  const ContinueWatchingViewModel({
    required this.course,
    required this.lesson,
    required this.progress,
  });

  int get watchedSeconds => progress.watchedSeconds;
  int get totalSeconds => lesson.durationSec;
  double get progressRatio =>
      totalSeconds > 0 ? (watchedSeconds / totalSeconds).clamp(0.0, 1.0) : 0.0;
}

class CoursesState {
  final AsyncValue<List<CourseViewModel>> courses;
  final ContinueWatchingViewModel? continueWatching;

  const CoursesState({
    required this.courses,
    this.continueWatching,
  });

  CoursesState copyWith({
    AsyncValue<List<CourseViewModel>>? courses,
    ContinueWatchingViewModel? Function()? continueWatching,
  }) {
    return CoursesState(
      courses: courses ?? this.courses,
      continueWatching: continueWatching != null
          ? continueWatching()
          : this.continueWatching,
    );
  }
}
