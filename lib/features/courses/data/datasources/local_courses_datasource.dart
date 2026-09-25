import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:thaheen/core/constants/app_assets.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';

class LocalCoursesDataSource {
  const LocalCoursesDataSource();

  Future<List<Course>> loadCourses() async {
    final jsonString = await rootBundle.loadString(AppAssets.coursesJson);
    final decoded = json.decode(jsonString) as Map<String, dynamic>;
    final coursesList = decoded['courses'] as List<dynamic>;
    return coursesList
        .map((json) => Course.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
