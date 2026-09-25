import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/utils/app_toast.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_controller.dart';

class CompletionSnackbarListener extends ConsumerWidget {
  final LessonPlayerArgs args;
  final Widget child;

  const CompletionSnackbarListener({
    super.key,
    required this.args,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      lessonPlayerControllerProvider(args)
          .select((s) => s.completionJustAchieved),
      (prev, next) {
        if (next == true && context.mounted) {
          AppToast.showSuccess(
            context,
            message: AppStrings.lessonCompletedMessage,
          );
          ref
              .read(lessonPlayerControllerProvider(args).notifier)
              .dismissCompletionNotification();
        }
      },
    );
    return child;
  }
}
