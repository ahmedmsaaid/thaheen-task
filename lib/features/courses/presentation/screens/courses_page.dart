import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/widgets/responsive_center.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/continue_watching_sliver.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_content_sliver.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_section_header.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveCenter(
      maxWidth: 800.w,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
          const ContinueWatchingSliver(),
          const CoursesSectionHeader(),
          const CoursesContentSliver(),
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],
      ),
    );
  }
}
