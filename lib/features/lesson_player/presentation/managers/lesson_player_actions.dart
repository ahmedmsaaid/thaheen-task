import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/utils/app_toast.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_controller.dart';

class LessonPlayerActions {
  final WidgetRef ref;
  final BetterPlayerService service;
  final String courseId;
  final String lessonId;
  final String? nextLessonId;
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
    AppToast.hideAll();
    save();
    try {
      context.pop();
    } catch (_) {}
  }

  void next(BuildContext context, [String? targetLessonId]) {
    final target = targetLessonId ?? nextLessonId;
    if (target == null) return;
    _navigateTo(context, target);
  }

  void goToLesson(BuildContext context, String targetLessonId) {
    if (targetLessonId == lessonId) return;
    _navigateTo(context, targetLessonId);
  }

  void _navigateTo(BuildContext context, String targetId) {
    AppToast.hideAll();
    save();
    try {
      context.pushReplacement(AppRouter.lessonPlayerPath(courseId, targetId));
    } catch (_) {
      try {
        context.go(AppRouter.lessonPlayerPath(courseId, targetId));
      } catch (_) {}
    }
  }

  void setSpeed(double s) {
    try {
      if (!isMounted()) return;
      ref.read(playbackSpeedProvider.notifier).state = s;
      service.setSpeed(s);
    } catch (_) {}
  }
}
