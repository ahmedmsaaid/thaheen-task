import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_list_item.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_empty_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_error_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/courses_loading_state.dart';

class CoursesContentSliver extends ConsumerWidget {
  const CoursesContentSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    return state.courses.when(
      loading: () => const SliverFillRemaining(child: CoursesLoadingState()),
      error: (error, _) => SliverFillRemaining(
        child: CoursesErrorState(
          message: error.toString(),
          onRetry: () => ref.read(coursesControllerProvider.notifier).loadCourses(),
        ),
      ),
      data: (courses) {
        if (courses.isEmpty) {
          return const SliverFillRemaining(child: CoursesEmptyState());
        }
        return SliverPadding(
          padding: EdgeInsets.only(bottom: 24.h, top: 4.h),
          sliver: SliverList.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final vm = courses[index];
              return CourseListItem(
                viewModel: vm,
                onTap: () => context.push(AppRouter.courseDetailsPath(vm.course.id)),
              );
            },
          ),
        );
      },
    );
  }
}
