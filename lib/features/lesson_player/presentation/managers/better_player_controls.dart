import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class BetterPlayerControls {
  const BetterPlayerControls._();

  static void seekBy(BetterPlayerController? controller, int seconds) {
    if (controller == null) return;
    final ctrl = controller.videoPlayerController;
    if (ctrl == null) return;
    final pos = ctrl.value.position;
    final dur = ctrl.value.duration ?? Duration.zero;
    final target = pos + Duration(seconds: seconds);
    final clamped = target < Duration.zero
        ? Duration.zero
        : (dur > Duration.zero && target > dur ? dur : target);
    controller.seekTo(clamped);
  }

  static void setSpeed(BetterPlayerController? controller, double speed) {
    try {
      controller?.setSpeed(speed);
    } catch (_) {}
  }

  static Future<void> setVolume(BetterPlayerController? controller, double volume) async {
    await controller?.setVolume(volume.clamp(0.0, 1.0));
  }

  static Future<void> enablePictureInPicture(BetterPlayerController? controller, GlobalKey key) async {
    try {
      await controller?.enablePictureInPicture(key);
    } catch (_) {}
  }

  static void dispose(BetterPlayerController? controller) {
    if (controller != null) {
      try {
        controller.pause();
        controller.dispose(forceDispose: true);
      } catch (_) {}
    }
  }
}
