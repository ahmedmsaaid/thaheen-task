import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/course_details/data/models/section_view_model.dart';

abstract class CourseDetailsRepoInterface {
  Future<Course> fetchCourse(String courseId);
  List<SectionViewModel> buildSectionViewModels({
    required Course course,
    required Map<String, dynamic> progressMap,
  });
}
