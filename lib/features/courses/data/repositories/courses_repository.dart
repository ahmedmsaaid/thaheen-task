import 'package:thaheen/features/courses/data/datasources/local_courses_datasource.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';

class CoursesRepository {
  final LocalCoursesDataSource _dataSource;

  const CoursesRepository(this._dataSource);

  Future<List<Course>> fetchCourses() => _dataSource.loadCourses();

  Future<Course> fetchCourse(String courseId) async {
    final courses = await fetchCourses();
    return courses.firstWhere((c) => c.id == courseId);
  }
}
