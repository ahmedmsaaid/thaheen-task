import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/continue_watching_card.dart';

class ContinueWatchingSliver extends ConsumerWidget {
  const ContinueWatchingSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final continueWatching = ref.watch(
      coursesControllerProvider.select((s) => s.continueWatching),
    );
    if (continueWatching == null) return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverToBoxAdapter(
      child: ContinueWatchingCard(
        viewModel: continueWatching,
        onTap: () => context.push(
          AppRouter.lessonPlayerPath(continueWatching.course.id, continueWatching.lesson.id),
        ),
      ),
    );
  }
}
