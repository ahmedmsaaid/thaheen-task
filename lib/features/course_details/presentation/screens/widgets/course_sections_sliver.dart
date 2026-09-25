import 'package:flutter/material.dart';
import 'package:thaheen/features/course_details/presentation/managers/course_details_state.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/course_content_empty_widget.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/section_expansion_tile.dart';

class CourseSectionsSliver extends StatelessWidget {
  const CourseSectionsSliver({
    super.key,
    required this.sections,
    required this.onLessonTap,
  });

  final List<SectionViewModel> sections;
  final void Function(LessonViewModel) onLessonTap;

  @override
  Widget build(BuildContext context) {
    final hasLessons =
        sections.isNotEmpty && sections.any((s) => s.lessons.isNotEmpty);

    if (!hasLessons) {
      return const SliverToBoxAdapter(
        child: CourseContentEmptyWidget(),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => SectionExpansionTile(
          sectionVM: sections[i],
          onLessonTap: onLessonTap,
        ),
        childCount: sections.length,
      ),
    );
  }
}
