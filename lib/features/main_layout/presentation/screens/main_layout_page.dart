import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/courses/presentation/screens/courses_page.dart';
import 'package:thaheen/features/main_layout/presentation/managers/main_nav_controller.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/main_app_bar.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/main_bottom_nav_bar.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/main_layout_next_lesson_listener.dart';
import 'package:thaheen/features/progress_tracking/presentation/screens/progress_tracking_page.dart';
import 'package:thaheen/features/watched_courses/presentation/screens/watched_courses_page.dart';

class MainLayoutPage extends ConsumerWidget {
  const MainLayoutPage({super.key});

  static const List<Widget> _tabs = [
    CoursesPage(),
    WatchedCoursesPage(),
    ProgressTrackingPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(mainNavControllerProvider);
    final ctrl = ref.read(mainNavControllerProvider.notifier);
    final colors = context.appColors;

    return MainLayoutNextLessonListener(
      child: Scaffold(
        extendBody: false,
        extendBodyBehindAppBar: false,
        backgroundColor: colors.background,
        body: Column(
          children: [
            const MainAppBar(),
            Expanded(
              child: IndexedStack(
                index: activeTab,
                children: _tabs,
              ),
            ),
          ],
        ),
        bottomNavigationBar: MainBottomNavBar(
          currentIndex: activeTab,
          onTabSelected: ctrl.setTab,
        ),
      ),
    );
  }
}

