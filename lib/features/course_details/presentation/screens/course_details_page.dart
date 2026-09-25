import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/widgets/custom_loading_indicator_widget.dart';
import 'package:thaheen/features/course_details/presentation/managers/course_details_controller.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/course_details_error_view.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/course_details_scroll_view.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/locked_lesson_sheet.dart';

class CourseDetailsPage extends ConsumerStatefulWidget {
  const CourseDetailsPage({super.key, required this.courseId});
  final String courseId;

  @override
  ConsumerState<CourseDetailsPage> createState() => _State();
}

class _State extends ConsumerState<CourseDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(courseDetailsControllerProvider(widget.courseId).notifier)
          .loadCourse();
    });
  }

  void _onTap(LessonViewModel vm) {
    if (vm.isLocked) {
      LockedLessonSheet.show(context, vm.lesson.title);
    } else {
      context.push(AppRouter.lessonPlayerPath(widget.courseId, vm.lesson.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(courseDetailsControllerProvider(widget.courseId));
    final ctrl =
        ref.read(courseDetailsControllerProvider(widget.courseId).notifier);

    return Scaffold(
      body: state.course.when(
        loading: () => const CustomLoadingIndicatorWidget(),
        error: (e, _) => CourseDetailsErrorView(
            message: e.toString(), onRetry: ctrl.loadCourse),
        data: (course) => CourseDetailsScrollView(
          course: course,
          state: state,
          onLessonTap: _onTap,
        ),
      ),
    );
  }
}
