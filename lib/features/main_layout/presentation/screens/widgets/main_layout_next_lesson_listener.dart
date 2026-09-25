import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/next_lesson_prompt_sheet.dart';

class MainLayoutNextLessonListener extends ConsumerWidget {
  final Widget child;

  const MainLayoutNextLessonListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(betterPlayerServiceProvider, (_, srv) {
      final prompt = srv.nextLessonPrompt;
      if (prompt != null && ModalRoute.of(context)?.isCurrent == true) {
        NextLessonPromptSheet.show(
          context,
          data: prompt,
          onDismiss: srv.clearNextLessonPrompt,
        );
      }
    });

    return child;
  }
}
