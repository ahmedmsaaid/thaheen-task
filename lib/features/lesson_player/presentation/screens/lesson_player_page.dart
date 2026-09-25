import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/widgets/custom_loading_indicator_widget.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_controller.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/completion_snackbar_listener.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_player_content.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/video_error_view.dart';

class LessonPlayerPage extends ConsumerStatefulWidget {
  const LessonPlayerPage(
      {super.key, required this.courseId, required this.lessonId});
  final String courseId;
  final String lessonId;

  @override
  ConsumerState<LessonPlayerPage> createState() => _LessonPlayerPageState();
}

class _LessonPlayerPageState extends ConsumerState<LessonPlayerPage> {
  LessonPlayerArgs get _args =>
      (courseId: widget.courseId, lessonId: widget.lessonId);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lessonPlayerControllerProvider(_args).notifier).loadLesson();
    });
  }

  @override
  void didUpdateWidget(covariant LessonPlayerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lessonId != widget.lessonId || oldWidget.courseId != widget.courseId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(lessonPlayerControllerProvider(_args).notifier).loadLesson();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lessonPlayerControllerProvider(_args));
    final ctrl = ref.read(lessonPlayerControllerProvider(_args).notifier);
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: CompletionSnackbarListener(
        args: _args,
        child: state.playerData.when(
          loading: () => const CustomLoadingIndicatorWidget(),
          error: (e, _) => VideoErrorView(onRetry: ctrl.loadLesson),
          data: (data) => LessonPlayerContent(
            key: ValueKey('${widget.courseId}_${widget.lessonId}'),
            courseId: widget.courseId,
            playerData: data,
            isCompleted: state.isCompleted,
          ),
        ),
      ),
    );
  }
}
