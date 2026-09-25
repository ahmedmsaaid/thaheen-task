import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/courses/data/repositories/courses_repository.dart';
import 'package:thaheen/features/course_details/data/models/section_view_model.dart';
import 'package:thaheen/features/course_details/domain/repos/course_details_repo_interface.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';
import 'package:thaheen/features/lesson_player/domain/unlock_policy.dart';

class CourseDetailsRepository implements CourseDetailsRepoInterface {
  final CoursesRepository _coursesRepository;
  final UnlockPolicy _unlockPolicy;

  const CourseDetailsRepository(
    this._coursesRepository,
    this._unlockPolicy,
  );

  @override
  Future<Course> fetchCourse(String courseId) =>
      _coursesRepository.fetchCourse(courseId);

  @override
  List<SectionViewModel> buildSectionViewModels({
    required Course course,
    required Map<String, dynamic> progressMap,
  }) {
    final allLessons = course.allLessons;
    final map = progressMap.cast<String, LessonProgressModel>();
    return course.sections.map((section) {
      final lessonVMs = section.lessons.map((lesson) {
        final progress = map[lesson.id];
        final isUnlocked = _unlockPolicy.isLessonUnlocked(
          lesson: lesson,
          allLessons: allLessons,
          progressMap: map,
        );
        final status = _resolveStatus(progress, isUnlocked);
        return LessonViewModel(
          lesson: lesson,
          status: status,
          watchedSeconds: progress?.watchedSeconds ?? 0,
        );
      }).toList();
      return SectionViewModel(section: section, lessons: lessonVMs);
    }).toList();
  }

  LessonStatus _resolveStatus(LessonProgressModel? progress, bool isUnlocked) {
    if (!isUnlocked) return LessonStatus.locked;
    if (progress == null) return LessonStatus.notStarted;
    if (progress.isCompleted) return LessonStatus.completed;
    if (progress.watchedSeconds > 0) return LessonStatus.inProgress;
    return LessonStatus.notStarted;
  }
}
