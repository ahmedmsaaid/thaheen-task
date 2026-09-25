import 'package:thaheen/features/courses/data/models/course_model.dart';

abstract class CoursesRepoInterface {
  Future<List<Course>> fetchCourses();
  Future<Course> fetchCourse(String courseId);
}
