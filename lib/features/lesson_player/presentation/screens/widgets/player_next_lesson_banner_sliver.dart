import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/next_lesson_button.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/next_lesson_countdown.dart';

class PlayerNextLessonBannerSliver extends StatelessWidget {
  final LessonModel? nextLesson;
  final bool showCountdown;
  final bool isDone;
  final VoidCallback onCountdownNext;
  final VoidCallback onCountdownCancel;
  final VoidCallback onNextLessonTap;

  const PlayerNextLessonBannerSliver({
    super.key,
    required this.nextLesson,
    required this.showCountdown,
    required this.isDone,
    required this.onCountdownNext,
    required this.onCountdownCancel,
    required this.onNextLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    if (nextLesson == null) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    if (showCountdown) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: NextLessonCountdown(
            onAutoNext: onCountdownNext,
            onCancel: onCountdownCancel,
          ),
        ),
      );
    }

    if (isDone) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: NextLessonButton(
            nextLesson: nextLesson!,
            onTap: onNextLessonTap,
          ),
        ),
      );
    }

    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}
