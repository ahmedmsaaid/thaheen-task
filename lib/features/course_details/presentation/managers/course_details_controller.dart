import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/features/course_details/presentation/managers/course_details_state.dart';

export 'package:thaheen/features/course_details/presentation/managers/course_details_state.dart';

class CourseDetailsController
    extends FamilyNotifier<CourseDetailsState, String> {
  @override
  CourseDetailsState build(String courseId) =>
      const CourseDetailsState(course: AsyncValue.loading());

  Future<void> loadCourse() async {
    state = state.copyWith(course: const AsyncValue.loading());
    try {
      final repo = ref.read(courseDetailsRepositoryProvider);
      final progressRepo = ref.read(progressRepositoryProvider);
      final calculator = ref.read(progressCalculatorProvider);

      final course = await repo.fetchCourse(arg);
      final progressMap = progressRepo.getCourseProgress(arg);
      final sectionVMs = repo.buildSectionViewModels(
        course: course,
        progressMap: progressMap,
      );

      final allLessons = course.allLessons;
      final doneCount = allLessons
          .where((l) => progressMap[l.id]?.isCompleted == true)
          .length;
      final percent = calculator.courseCompletionPercentage(
        totalLessons: allLessons.length,
        completedLessons: doneCount,
      );

      state = state.copyWith(
        course: AsyncValue.data(course),
        sections: sectionVMs,
        progressPercentage: percent,
        completedLessons: doneCount,
      );
    } catch (e, st) {
      state = state.copyWith(course: AsyncValue.error(e, st));
    }
  }
}

final courseDetailsControllerProvider = NotifierProviderFamily<
    CourseDetailsController, CourseDetailsState, String>(
  CourseDetailsController.new,
);
