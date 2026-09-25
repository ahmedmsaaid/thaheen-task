import 'dart:async';
import 'package:flutter/material.dart';

class BetterPlayerSessionState {
  String? currentAssetPath;
  String? currentLessonId;
  String? currentCourseId;
  bool isPlaying = false;
  bool hasError = false;
  bool isLoading = false;
  Timer? saveTimer;
  VoidCallback? onSave;
  VoidCallback? onFinished;
  VoidCallback? onError;

  bool isCurrentLesson(String id) => currentLessonId == id;

  void detachCallbacks() {
    onSave = null;
    onFinished = null;
    onError = null;
  }

  void setup({
    required VoidCallback onSave,
    VoidCallback? onFinished,
    VoidCallback? onError,
  }) {
    this.onSave = onSave;
    this.onFinished = onFinished;
    this.onError = onError;
    hasError = false;
    isLoading = true;
  }

  void startSaveTimer(bool Function() isDisposed, Future<void> Function() onPeriodicSave) {
    saveTimer?.cancel();
    saveTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (!isDisposed()) {
        onPeriodicSave();
        onSave?.call();
      }
    });
  }

  void reset() {
    saveTimer?.cancel();
    saveTimer = null;
    isPlaying = false;
    hasError = false;
    isLoading = false;
  }

  void clear() {
    reset();
    currentLessonId = null;
    currentCourseId = null;
    currentAssetPath = null;
  }
}
