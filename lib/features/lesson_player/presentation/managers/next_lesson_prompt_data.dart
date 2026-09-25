import 'package:thaheen/features/courses/data/models/lesson_model.dart';

class NextLessonPromptData {
  final String courseId;
  final Lesson completedLesson;
  final Lesson nextLesson;

  const NextLessonPromptData({
    required this.courseId,
    required this.completedLesson,
    required this.nextLesson,
  });
}
