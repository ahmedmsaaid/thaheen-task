import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_data_fetcher.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_state.dart';

export 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_state.dart';

class LessonPlayerController
    extends FamilyNotifier<LessonPlayerState, LessonPlayerArgs> {
  @override
  LessonPlayerState build(LessonPlayerArgs arg) =>
      const LessonPlayerState(playerData: AsyncValue.loading());

  Future<void> loadLesson() async {
    state = state.copyWith(playerData: const AsyncValue.loading());
    try {
      final data = await fetchPlayerData(ref, arg);
      final repo = ref.read(progressRepositoryProvider);
      final saved = repo.getProgress(arg.courseId, arg.lessonId);
      state = LessonPlayerState(
        playerData: AsyncValue.data(data),
        isCompleted: saved?.isCompleted ?? false,
      );
    } catch (e, st) {
      state = state.copyWith(playerData: AsyncValue.error(e, st));
    }
  }

  Future<void> onPositionChanged(
      {required int watchedSeconds, required int totalSeconds}) async {
    final calc = ref.read(progressCalculatorProvider);
    final isDone = !state.isCompleted &&
        calc.isCompleted(
            watchedSeconds: watchedSeconds, totalSeconds: totalSeconds);
    await ref.read(progressRepositoryProvider).saveWatchPosition(
          courseId: arg.courseId,
          lessonId: arg.lessonId,
          watchedSeconds: watchedSeconds,
          isCompleted: isDone || state.isCompleted,
        );
    if (isDone) {
      state = state.copyWith(isCompleted: true, completionJustAchieved: true);
      await loadLesson();
    }
  }

  void dismissCompletionNotification() =>
      state = state.copyWith(completionJustAchieved: false);
}

final lessonPlayerControllerProvider = NotifierProviderFamily<
    LessonPlayerController, LessonPlayerState, LessonPlayerArgs>(
  LessonPlayerController.new,
);
