import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class BetterPlayerEventBinder {
  const BetterPlayerEventBinder._();

  static void bindEvents({
    required BetterPlayerController controller,
    required bool Function() isDisposed,
    required void Function(bool isPlaying) onPlayStateChanged,
    required VoidCallback onFinished,
    required VoidCallback onError,
    required VoidCallback safeNotify,
  }) {
    controller.addEventsListener((event) {
      if (isDisposed()) return;
      switch (event.betterPlayerEventType) {
        case BetterPlayerEventType.play:
        case BetterPlayerEventType.initialized:
          onPlayStateChanged(true);
          safeNotify();
          break;
        case BetterPlayerEventType.pause:
          onPlayStateChanged(false);
          safeNotify();
          break;
        case BetterPlayerEventType.finished:
          onPlayStateChanged(false);
          onFinished();
          safeNotify();
          break;
        case BetterPlayerEventType.exception:
          onError();
          safeNotify();
          break;
        default:
          break;
      }
    });
  }
}
