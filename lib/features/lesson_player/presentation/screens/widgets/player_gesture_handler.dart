import 'dart:async';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class PlayerGestureHandler {
  final BetterPlayerController controller;
  final VoidCallback onStateChanged;

  bool showVolumeHud = false, showDoubleTapLeft = false, showDoubleTapRight = false;
  double volume = 1.0;
  Timer? hudTimer, doubleTapTimer;

  PlayerGestureHandler({required this.controller, required this.onStateChanged}) {
    volume = controller.videoPlayerController?.value.volume ?? 1.0;
  }

  void onVerticalDragStart(DragStartDetails details) {
    volume = controller.videoPlayerController?.value.volume ?? volume;
    hudTimer?.cancel();
    showVolumeHud = true;
    onStateChanged();
  }

  void onVerticalDrag(DragUpdateDetails details) {
    volume = (volume - (details.delta.dy / 120.0)).clamp(0.0, 1.0);
    controller.setVolume(volume);
    hudTimer?.cancel();
    showVolumeHud = true;
    onStateChanged();
  }

  void onVerticalDragEnd(DragEndDetails details) {
    hudTimer?.cancel();
    hudTimer = Timer(const Duration(milliseconds: 1200), () {
      showVolumeHud = false;
      onStateChanged();
    });
  }

  void handleDoubleTapSide({required bool isLeft}) {
    _seekBy(isLeft ? -10 : 10);
    _triggerBadge(isLeft: isLeft);
  }

  void _seekBy(int sec) {
    final ctrl = controller.videoPlayerController;
    if (ctrl == null) return;
    final target = ctrl.value.position + Duration(seconds: sec);
    final dur = ctrl.value.duration ?? Duration.zero;
    final clamped = target < Duration.zero ? Duration.zero : (dur > Duration.zero && target > dur ? dur : target);
    controller.seekTo(clamped);
  }

  void _triggerBadge({required bool isLeft}) {
    doubleTapTimer?.cancel();
    showDoubleTapLeft = isLeft;
    showDoubleTapRight = !isLeft;
    onStateChanged();
    doubleTapTimer = Timer(const Duration(milliseconds: 700), () {
      showDoubleTapLeft = false;
      showDoubleTapRight = false;
      onStateChanged();
    });
  }

  void dispose() {
    hudTimer?.cancel();
    doubleTapTimer?.cancel();
  }
}
