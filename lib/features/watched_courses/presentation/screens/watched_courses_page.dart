import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/core/widgets/custom_loading_indicator_widget.dart';
import 'package:thaheen/core/widgets/responsive_center.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/watched_courses/presentation/screens/widgets/watched_course_card.dart';
import 'package:thaheen/features/watched_courses/presentation/screens/widgets/watched_empty_view.dart';

class WatchedCoursesPage extends ConsumerWidget {
  const WatchedCoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: state.courses.when(
        loading: () => const CustomLoadingIndicatorWidget(),
        error: (e, _) => const WatchedEmptyView(),
        data: (list) {
          final started = list.where((c) => c.isStarted).toList();
          if (started.isEmpty) return const WatchedEmptyView();
          return ResponsiveCenter(
            maxWidth: 800,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 22,
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(AppStrings.navWatched,
                            style: AppTextStyles.h2(context)),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 100.h),
                  sliver: SliverList.builder(
                    itemCount: started.length,
                    itemBuilder: (_, i) =>
                        WatchedCourseCard(viewModel: started[i]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
