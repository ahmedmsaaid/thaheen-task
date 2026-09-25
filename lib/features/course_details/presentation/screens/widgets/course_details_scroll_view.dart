import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/widgets/responsive_center.dart';
import 'package:thaheen/features/course_details/presentation/managers/course_details_controller.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/course_details_app_bar.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/course_info_header.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/course_sections_sliver.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';

class CourseDetailsScrollView extends StatelessWidget {
  final Course course;
  final CourseDetailsState state;
  final void Function(LessonViewModel) onLessonTap;

  const CourseDetailsScrollView({
    super.key,
    required this.course,
    required this.state,
    required this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxWidth: 800,
      child: CustomScrollView(
        slivers: [
          CourseDetailsAppBar(course: course),
          SliverToBoxAdapter(
            child: CourseInfoHeader(
              course: course,
              progressPercentage: state.progressPercentage,
              completedLessons: state.completedLessons,
            ),
          ),
          CourseSectionsSliver(
            sections: state.sections,
            onLessonTap: onLessonTap,
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 32.h)),
        ],

      ),
    );
  }
}
