import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/core/utils/app_toast.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_actions.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_state.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_scroll_view.dart';

class LessonPlayerContent extends ConsumerStatefulWidget {
  final String courseId;
  final PlayerDataInternal playerData;
  final bool isCompleted;

  const LessonPlayerContent({
    super.key,
    required this.courseId,
    required this.playerData,
    required this.isCompleted,
  });

  @override
  ConsumerState<LessonPlayerContent> createState() => _State();
}

class _State extends ConsumerState<LessonPlayerContent> {
  bool _showCountdown = false;
  late final BetterPlayerService _srv;
  late final LessonPlayerActions _act;

  @override
  void initState() {
    super.initState();
    _srv = ref.read(betterPlayerServiceProvider);
    _act = LessonPlayerActions(
      ref: ref,
      service: _srv,
      courseId: widget.courseId,
      lessonId: widget.playerData.currentLesson.id,
      nextLessonId: widget.playerData.nextLesson?.id,
      isMounted: () => mounted,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _initPlayer());
  }

  void _initPlayer() {
    if (!mounted) return;
    final p = widget.playerData;
    _srv.init(
      assetPath: p.currentLesson.videoPath,
      courseId: widget.courseId,
      lessonId: p.currentLesson.id,
      resumeSec: p.resumeFromSeconds,
      speed: ref.read(playbackSpeedProvider),
      title: p.currentLesson.title,
      author: p.course.title,
      onSave: () => mounted ? _act.save() : null,
      onFinished: () {
        _srv.clearNextLessonPrompt();
        if (mounted && widget.playerData.nextLesson != null) {
          setState(() => _showCountdown = true);
        }
      },
      onError: () {
        if (!mounted) return;
        setState(() {});
        AppToast.showError(
          context,
          message: AppStrings.videoLoadError,
          subtitle: AppStrings.videoLoadErrorSubtitle,
        );
      },
    ).then((_) => mounted ? setState(() {}) : null);
  }

  @override
  void dispose() {
    _srv.detachCallbacks();
    if (mounted) _act.save();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PlayerScrollView(
        data: widget.playerData,
        isDone: widget.isCompleted,
        speed: ref.watch(playbackSpeedProvider),
        service: ref.watch(betterPlayerServiceProvider),
        onRetry: _initPlayer,
        act: _act,
        showCountdown: _showCountdown,
        onCountdownCancel: () => setState(() => _showCountdown = false),
        onCountdownNext: () {
          setState(() => _showCountdown = false);
          _act.next(context);
        },
      );
}
