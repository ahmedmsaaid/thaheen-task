import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_controls.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_progress_saver.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_session_loader.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_session_state.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/next_lesson_prompt_data.dart';

class BetterPlayerService extends ChangeNotifier {
  final Ref ref;
  BetterPlayerController? controller;
  bool _isDisposed = false;
  final BetterPlayerSessionState _session = BetterPlayerSessionState();
  NextLessonPromptData? _nextLessonPrompt;

  BetterPlayerService(this.ref);

  String? get currentAssetPath => _session.currentAssetPath;
  String? get currentLessonId => _session.currentLessonId;
  String? get currentCourseId => _session.currentCourseId;
  bool get isPlaying => _session.isPlaying;
  bool get hasError => _session.hasError;
  bool get isLoading => _session.isLoading;
  bool get isReady => controller?.isVideoInitialized() == true;
  NextLessonPromptData? get nextLessonPrompt => _nextLessonPrompt;
  bool isCurrentLesson(String id) => _session.isCurrentLesson(id);

  int get currentPositionSec => controller?.videoPlayerController?.value.position.inSeconds ?? 0;
  int get totalDurationSec => controller?.videoPlayerController?.value.duration?.inSeconds ?? 0;
  double get volume => controller?.videoPlayerController?.value.volume ?? 1.0;

  void clearNextLessonPrompt() { _nextLessonPrompt = null; _safeNotify(); }
  void detachCallbacks() => _session.detachCallbacks();
  Future<void> enablePictureInPicture() => BetterPlayerControls.enablePictureInPicture(controller, GlobalKey());
  Future<void> setVolume(double vol) => BetterPlayerControls.setVolume(controller, vol);
  void seekBy(int sec) => BetterPlayerControls.seekBy(controller, sec);
  void setSpeed(double spd) => BetterPlayerControls.setSpeed(controller, spd);

  void _safeNotify() {
    if (_isDisposed) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) notifyListeners();
    });
  }

  void play() { controller?.play(); _session.isPlaying = true; _safeNotify(); }
  void pause() { controller?.pause(); _session.isPlaying = false; saveCurrentProgress(); _safeNotify(); }

  Future<void> saveCurrentProgress({bool isFinished = false}) =>
      BetterPlayerProgressSaver.save(ref: ref, session: _session, controller: controller, isFinished: isFinished);

  Future<void> onVideoFinished() async {
    await saveCurrentProgress(isFinished: true);
    _nextLessonPrompt = await BetterPlayerProgressSaver.checkNextPrompt(ref: ref, session: _session);
    _safeNotify();
  }

  Future<void> init({
    required String assetPath, required String courseId, required String lessonId,
    required int resumeSec, required double speed, String? title, String? author,
    required VoidCallback onSave, VoidCallback? onFinished, VoidCallback? onError,
  }) async {
    _session.setup(onSave: onSave, onFinished: onFinished, onError: onError);
    _safeNotify();
    if (_session.isCurrentLesson(lessonId) && controller != null && isReady) {
      setSpeed(speed);
      _session.isLoading = false;
      if (!isPlaying) play();
      _safeNotify();
      return;
    }
    _disposeControllerOnly();
    _isDisposed = false;
    controller = await BetterPlayerSessionLoader.load(
      assetPath: assetPath, courseId: courseId, lessonId: lessonId,
      resumeSec: resumeSec, speed: speed, title: title, author: author,
      session: _session,
      isDisposed: () => _isDisposed, safeNotify: _safeNotify,
      onPeriodicSave: saveCurrentProgress, onVideoFinished: onVideoFinished,
    );
  }

  void _disposeControllerOnly() {
    _session.reset();
    BetterPlayerControls.dispose(controller);
    controller = null;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _disposeControllerOnly();
    _session.clear();
    super.dispose();
  }
}
