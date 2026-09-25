import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_actions.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/course_lessons_playlist_tab.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/course_overview_tab.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_notes_resources_tab.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_segmented_tab_bar.dart';

class PlayerTabBarSection extends StatefulWidget {
  final CourseModel course;
  final String activeLessonId;
  final LessonPlayerActions act;
  final BetterPlayerService service;

  const PlayerTabBarSection({
    super.key,
    required this.course,
    required this.activeLessonId,
    required this.act,
    required this.service,
  });

  @override
  State<PlayerTabBarSection> createState() => _PlayerTabBarSectionState();
}

class _PlayerTabBarSectionState extends State<PlayerTabBarSection> {
  int _selectedTabIndex = 0;

  static const List<PlayerTabItem> _tabs = [
    (title: PlayerStrings.tabLessons, icon: Icons.playlist_play_rounded),
    (title: PlayerStrings.tabOverview, icon: Icons.info_outline_rounded),
    (title: PlayerStrings.tabNotes, icon: Icons.description_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlayerSegmentedTabBar(
            tabs: _tabs,
            selectedIndex: _selectedTabIndex,
            onTabSelected: (idx) => setState(() => _selectedTabIndex = idx),
          ),
          SizedBox(height: 16.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: switch (_selectedTabIndex) {
              0 => CourseLessonsPlaylistTab(
                  key: const ValueKey(0),
                  course: widget.course,
                  activeLessonId: widget.activeLessonId,
                  act: widget.act,
                ),
              1 => CourseOverviewTab(
                  key: const ValueKey(1),
                  course: widget.course,
                ),
              _ => LessonNotesResourcesTab(
                  key: const ValueKey(2),
                  service: widget.service,
                ),
            },
          ),
        ],
      ),
    );
  }
}
