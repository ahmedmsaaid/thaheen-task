import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_initializer.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_session_state.dart';

class BetterPlayerSessionLoader {
  const BetterPlayerSessionLoader._();

  static Future<BetterPlayerController?> load({
    required String assetPath,
    required String courseId,
    required String lessonId,
    required int resumeSec,
    required double speed,
    String? title,
    String? author,
    required BetterPlayerSessionState session,
    required bool Function() isDisposed,
    required VoidCallback safeNotify,
    required Future<void> Function() onPeriodicSave,
    required Future<void> Function() onVideoFinished,
  }) async {
    session.currentAssetPath = assetPath;
    session.currentLessonId = lessonId;
    session.currentCourseId = courseId;

    try {
      debugPrint('[BetterPlayerSessionLoader] Loading asset: $assetPath (lessonId: $lessonId)');
      final controller = await BetterPlayerInitializer.create(
        assetPath: assetPath,
        resumeSec: resumeSec,
        speed: speed,
        title: title,
        author: author,
        isDisposed: isDisposed,
        onPlayStateChanged: (p) => session.isPlaying = p,
        onFinished: () {
          debugPrint('[BetterPlayerSessionLoader] onVideoFinished fired');
          onVideoFinished();
          session.onSave?.call();
          session.onFinished?.call();
        },
        onError: () {
          debugPrint('[BetterPlayerSessionLoader] video playback error event');
          session.hasError = true;
          session.onError?.call();
          safeNotify();
        },
        safeNotify: safeNotify,
      );

      session.startSaveTimer(isDisposed, onPeriodicSave);
      session.isLoading = false;
      session.hasError = false;
      safeNotify();
      debugPrint('[BetterPlayerSessionLoader] Successfully loaded: $assetPath');
      return controller;
    } catch (e, st) {
      debugPrint('[BetterPlayerSessionLoader] Error loading video: $e\n$st');
      session.isLoading = false;
      session.hasError = true;
      session.onError?.call();
      safeNotify();
      return null;
    }
  }
}

