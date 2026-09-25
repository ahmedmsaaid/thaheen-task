import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/course_details/data/models/section_view_model.dart';

export 'package:thaheen/features/course_details/data/models/section_view_model.dart';

class CourseDetailsState {
  final AsyncValue<Course> course;
  final List<SectionViewModel> sections;
  final double progressPercentage;
  final int completedLessons;

  const CourseDetailsState({
    required this.course,
    this.sections = const [],
    this.progressPercentage = 0,
    this.completedLessons = 0,
  });

  CourseDetailsState copyWith({
    AsyncValue<Course>? course,
    List<SectionViewModel>? sections,
    double? progressPercentage,
    int? completedLessons,
  }) {
    return CourseDetailsState(
      course: course ?? this.course,
      sections: sections ?? this.sections,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      completedLessons: completedLessons ?? this.completedLessons,
    );
  }
}
