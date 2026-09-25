import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_controller.dart';

import 'package:thaheen/core/utils/app_toast.dart';

class LessonPlayerActions {
  final WidgetRef ref;
  final BetterPlayerService service;
  final String courseId;
  final String lessonId;
  final String? nextLessonId;

  /// A getter that returns whether the widget is still mounted.
  final bool Function() isMounted;

  const LessonPlayerActions({
    required this.ref,
    required this.service,
    required this.courseId,
    required this.lessonId,
    required this.isMounted,
    this.nextLessonId,
  });

  void save() {
    try {
      final pos = service.currentPositionSec;
      final total = service.totalDurationSec;
      if (total > 0) {
        final args = (courseId: courseId, lessonId: lessonId);
        ref.read(lessonPlayerControllerProvider(args).notifier).onPositionChanged(
              watchedSeconds: pos,
              totalSeconds: total,
            );
        ref.read(coursesControllerProvider.notifier).loadCourses();
      }
    } catch (_) {}
  }

  void back(BuildContext context) {
    try {
      AppToast.hideAll();
      save();
      context.pop();
    } catch (e, st) {
      debugPrint('[LessonPlayerActions] back() error: $e\n$st');
    }
  }

  void next(BuildContext context) {
    try {
      AppToast.hideAll();
      debugPrint('[LessonPlayerActions] next() nextLessonId: $nextLessonId');
      if (nextLessonId == null) return;
      save();
      context.pushReplacement(AppRouter.lessonPlayerPath(courseId, nextLessonId!));
    } catch (e, st) {
      debugPrint('[LessonPlayerActions] next() error: $e\n$st');
      try {
        context.go(AppRouter.lessonPlayerPath(courseId, nextLessonId!));
      } catch (e2, st2) {
        debugPrint('[LessonPlayerActions] next() fallback error: $e2\n$st2');
      }
    }
  }

  void goToLesson(BuildContext context, String targetLessonId) {
    try {
      AppToast.hideAll();
      debugPrint('[LessonPlayerActions] goToLesson($targetLessonId)');
      if (targetLessonId == lessonId) return;
      save();
      context.pushReplacement(AppRouter.lessonPlayerPath(courseId, targetLessonId));
    } catch (e, st) {
      debugPrint('[LessonPlayerActions] goToLesson() error: $e\n$st');
      try {
        context.go(AppRouter.lessonPlayerPath(courseId, targetLessonId));
      } catch (e2, st2) {
        debugPrint('[LessonPlayerActions] goToLesson() fallback error: $e2\n$st2');
      }
    }
  }

  void setSpeed(double s) {
    try {
      if (!isMounted()) return;
      ref.read(playbackSpeedProvider.notifier).state = s;
      service.setSpeed(s);
    } catch (e, st) {
      debugPrint('[LessonPlayerActions] setSpeed() error: $e\n$st');
    }
  }
}
