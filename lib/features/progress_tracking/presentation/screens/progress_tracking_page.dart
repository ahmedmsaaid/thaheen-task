import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/core/widgets/custom_loading_indicator_widget.dart';
import 'package:thaheen/core/widgets/responsive_center.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/progress_tracking/presentation/screens/widgets/progress_course_tile.dart';
import 'package:thaheen/features/progress_tracking/presentation/screens/widgets/progress_stat_box.dart';
import 'package:thaheen/features/progress_tracking/presentation/screens/widgets/progress_summary_card.dart';

class ProgressTrackingPage extends ConsumerWidget {
  const ProgressTrackingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: ResponsiveCenter(
          maxWidth: 800,
          child: Text(AppStrings.progressTitle, style: AppTextStyles.h2(context)),
        ),
        centerTitle: false,
        backgroundColor: colors.background,
        elevation: 0,
      ),
      body: state.courses.when(
        loading: () => const CustomLoadingIndicatorWidget(),
        error: (e, _) => const SizedBox.shrink(),
        data: (courses) {
          final doneLessons =
              courses.fold<int>(0, (sum, c) => sum + c.completedLessons);
          final totalLessons =
              courses.fold<int>(0, (sum, c) => sum + c.course.totalLessons);
          final overall =
              totalLessons > 0 ? doneLessons / totalLessons : 0.0;

          return ResponsiveCenter(
            maxWidth: 800,
            child: ListView(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 110.h),
              children: [
                ProgressSummaryCard(overallRatio: overall),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    ProgressStatBox(
                      title: AppStrings.completedLessonsStat,
                      value: '$doneLessons',
                      icon: Icons.check_circle_outline_rounded,
                      color: colors.success,
                    ),
                    SizedBox(width: 12.w),
                    ProgressStatBox(
                      title: AppStrings.totalCoursesStat,
                      value: '${courses.length}',
                      icon: Icons.school_outlined,
                      color: colors.primary,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Text(AppStrings.coursesTitle, style: AppTextStyles.h3(context)),
                SizedBox(height: 12.h),
                ...courses.map((c) => ProgressCourseTile(viewModel: c)),
              ],
            ),
          );
        },
      ),
    );
  }
}
