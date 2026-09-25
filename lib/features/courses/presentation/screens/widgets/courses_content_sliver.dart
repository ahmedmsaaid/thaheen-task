import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/utils/arabic_normalizer.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_list_item.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_empty_search_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_empty_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_error_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_loading_state.dart';

class CoursesContentSliver extends ConsumerWidget {
  const CoursesContentSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    final query = ref.watch(courseSearchQueryProvider);

    return state.courses.when(
      loading: () => const SliverFillRemaining(child: CoursesLoadingState()),
      error: (error, _) => SliverFillRemaining(
        child: CoursesErrorState(
          message: error.toString(),
          onRetry: () =>
              ref.read(coursesControllerProvider.notifier).loadCourses(),
        ),
      ),
      data: (courses) {
        if (courses.isEmpty) {
          return const SliverFillRemaining(child: CoursesEmptyState());
        }

        final filtered = courses.where((c) {
          return ArabicNormalizer.containsQuery(c.course.title, query) ||
              ArabicNormalizer.containsQuery(c.course.instructor, query);
        }).toList();

        if (filtered.isEmpty) {
          return const SliverFillRemaining(child: CoursesEmptySearchState());
        }

        return SliverPadding(
          padding: EdgeInsets.only(bottom: 24.h, top: 4.h),
          sliver: SliverList.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final vm = filtered[index];
              return CourseListItem(
                viewModel: vm,
                onTap: () =>
                    context.push(AppRouter.courseDetailsPath(vm.course.id)),
              );
            },
          ),
        );
      },
    );
  }
}

