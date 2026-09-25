import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/course_learning_objectives_card.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/course_overview_card.dart';

class CourseOverviewTab extends StatelessWidget {
  final CourseModel course;

  const CourseOverviewTab({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourseOverviewCard(course: course),
        SizedBox(height: 16.h),
        const CourseLearningObjectivesCard(),
      ],
    );
  }
}
