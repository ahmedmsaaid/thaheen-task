import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/router/app_page_transitions.dart';
import 'package:thaheen/features/course_details/presentation/screens/course_details_page.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/lesson_player_page.dart';
import 'package:thaheen/features/main_layout/presentation/screens/main_layout_page.dart';
import 'package:thaheen/features/splash/presentation/screens/splash_page.dart';

class AppRouter {
  AppRouter._();

  static const splash = '/';
  static const mainLayout = '/main';
  static const courseDetails = '/courses/:courseId';
  static const lessonPlayer = '/courses/:courseId/lessons/:lessonId';

  static String courseDetailsPath(String id) => '/courses/$id';
  static String lessonPlayerPath(String cId, String lId) => '/courses/$cId/lessons/$lId';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        pageBuilder: (c, s) => AppPageTransitions.fade(child: const SplashPage(), state: s),
      ),
      GoRoute(
        path: mainLayout,
        pageBuilder: (c, s) => AppPageTransitions.fade(child: const MainLayoutPage(), state: s),
      ),
      GoRoute(
        path: courseDetails,
        pageBuilder: (c, s) => AppPageTransitions.slideHorizontally(
          child: CourseDetailsPage(courseId: s.pathParameters['courseId']!),
          state: s,
        ),
      ),
      GoRoute(
        path: lessonPlayer,
        pageBuilder: (c, s) => AppPageTransitions.slideUp(
          child: LessonPlayerPage(
            key: ValueKey('${s.pathParameters['courseId']}_${s.pathParameters['lessonId']}'),
            courseId: s.pathParameters['courseId']!,
            lessonId: s.pathParameters['lessonId']!,
          ),
          state: s,
        ),
      ),
    ],
  );
}
