import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_state.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_state_mapper.dart';

export 'package:thaheen/features/courses/presentation/managers/courses_state.dart';

class CoursesController extends Notifier<CoursesState> {
  @override
  CoursesState build() {
    Future.microtask(() => loadCourses());
    return const CoursesState(courses: AsyncValue.loading());
  }

  Future<void> loadCourses() async {
    try {
      final coursesRepo = ref.read(coursesRepositoryProvider);
      final progressRepo = ref.read(progressRepositoryProvider);
      final calculator = ref.read(progressCalculatorProvider);

      final courses = await coursesRepo.fetchCourses();
      final viewModels = courses.map((course) {
        final pMap = progressRepo.getCourseProgress(course.id);
        final all = course.allLessons;
        final done = all.where((l) => pMap[l.id]?.isCompleted == true).length;
        final started = all.any((l) => (pMap[l.id]?.watchedSeconds ?? 0) > 0 || pMap[l.id]?.isCompleted == true);
        final ratio = calculator.courseCompletionPercentage(
          totalLessons: all.length,
          completedLessons: done,
        );
        return CourseViewModel(
          course: course,
          completedLessons: done,
          progressRatio: ratio,
          hasStarted: started,
        );
      }).toList();

      final last = progressRepo.getLastWatchedIncomplete() ?? progressRepo.getLatestWatched();
      final playerService = ref.read(betterPlayerServiceProvider);
      final continueVM = findContinueWatching(
        courses,
        last,
        activeCourseId: playerService.currentCourseId,
        activeLessonId: playerService.currentLessonId,
      );

      state = state.copyWith(
        courses: AsyncValue.data(viewModels),
        continueWatching: () => continueVM,
      );
    } catch (e, st) {
      state = state.copyWith(courses: AsyncValue.error(e, st));
    }
  }
}

final coursesControllerProvider =
    NotifierProvider<CoursesController, CoursesState>(CoursesController.new);
