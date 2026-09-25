import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/course_details/data/models/lesson_status.dart';

export 'package:thaheen/features/course_details/data/models/lesson_status.dart';

class LessonViewModel {
  final Lesson lesson;
  final LessonStatus status;
  final int watchedSeconds;

  const LessonViewModel({
    required this.lesson,
    required this.status,
    required this.watchedSeconds,
  });

  bool get isLocked => status == LessonStatus.locked;
  bool get isCompleted => status == LessonStatus.completed;
}
