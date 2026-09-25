import 'package:thaheen/features/courses/data/datasources/local_courses_datasource.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';

class CourseDetailsDataSource {
  final LocalCoursesDataSource _dataSource;
  const CourseDetailsDataSource(this._dataSource);

  Future<Course> getCourseById(String id) async {
    final courses = await _dataSource.loadCourses();
    return courses.firstWhere((c) => c.id == id);
  }
}
