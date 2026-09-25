import 'package:thaheen/features/courses/data/models/lesson_model.dart';

class Section {
  final String id;
  final String title;
  final List<Lesson> lessons;

  const Section({
    required this.id,
    required this.title,
    required this.lessons,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] as String,
      title: json['title'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((l) => Lesson.fromJson(l as Map<String, dynamic>))
          .toList(),
    );
  }

  int get totalLessons => lessons.length;

  int get totalDurationSec =>
      lessons.fold(0, (sum, l) => sum + l.durationSec);
}

typedef SectionModel = Section;
