import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/widgets/responsive_center.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_actions.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_state.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_info_section.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_app_bar.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_next_lesson_banner_sliver.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_tab_bar_section.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/video_player_section.dart';

class PlayerScrollView extends StatelessWidget {
  final PlayerDataInternal data;
  final bool isDone;
  final double speed;
  final BetterPlayerService service;
  final VoidCallback onRetry;
  final LessonPlayerActions act;
  final bool showCountdown;
  final VoidCallback onCountdownCancel;
  final VoidCallback onCountdownNext;

  const PlayerScrollView({
    super.key,
    required this.data,
    required this.isDone,
    required this.speed,
    required this.service,
    required this.onRetry,
    required this.act,
    required this.showCountdown,
    required this.onCountdownCancel,
    required this.onCountdownNext,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxWidth: 900,
      child: CustomScrollView(
        slivers: [
          PlayerAppBar(
            courseTitle: data.course.title,
            lessonTitle: data.currentLesson.title,
            onBackPressed: () => act.back(context),
          ),
          SliverToBoxAdapter(
            child: VideoPlayerSection(
              betterController: service.controller,
              playerKey: service.playerKey,
              hasError: service.hasError,
              onRetry: onRetry,
            ),
          ),
          PlayerNextLessonBannerSliver(
            nextLesson: data.nextLesson,
            showCountdown: showCountdown,
            isDone: isDone,
            onCountdownNext: onCountdownNext,
            onCountdownCancel: onCountdownCancel,
            onNextLessonTap: () => act.next(context),
          ),
          SliverToBoxAdapter(
            child: LessonInfoSection(
              lesson: data.currentLesson,
              course: data.course,
              isCompleted: isDone,
              currentSpeed: speed,
              service: service,
              act: act,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 8.h)),
          SliverToBoxAdapter(
            child: PlayerTabBarSection(
              course: data.course,
              activeLessonId: data.currentLesson.id,
              act: act,
              service: service,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 100.h)),
        ],

      ),
    );
  }
}
