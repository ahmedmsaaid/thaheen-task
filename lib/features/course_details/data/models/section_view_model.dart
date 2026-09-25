import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/course_details/data/models/lesson_view_model.dart';

export 'package:thaheen/features/course_details/data/models/lesson_view_model.dart';

class SectionViewModel {
  final Section section;
  final List<LessonViewModel> lessons;

  const SectionViewModel({
    required this.section,
    required this.lessons,
  });

  int get completedCount => lessons.where((l) => l.isCompleted).length;
  bool get isFullyCompleted =>
      completedCount == lessons.length && lessons.isNotEmpty;
}
