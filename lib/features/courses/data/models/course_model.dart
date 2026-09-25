import 'package:thaheen/features/courses/data/models/lesson_model.dart';
import 'package:thaheen/features/courses/data/models/section_model.dart';

export 'package:thaheen/features/courses/data/models/lesson_model.dart';
export 'package:thaheen/features/courses/data/models/section_model.dart';

class Course {
  final String id;
  final String title;
  final String instructor;
  final String thumbnail;
  final List<Section> sections;

  const Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.thumbnail,
    required this.sections,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      instructor: json['instructor'] as String,
      thumbnail: json['thumbnail'] as String,
      sections: (json['sections'] as List<dynamic>)
          .map((s) => Section.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }

  List<Lesson> get allLessons => sections.expand((s) => s.lessons).toList();
  int get totalLessons => allLessons.length;
  int get totalSections => sections.length;
}

typedef CourseModel = Course;
