import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/lesson_player_actions.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_quick_action_button.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/speed_selector_sheet.dart';

class LessonQuickActionsBar extends StatelessWidget {
  final double currentSpeed;
  final BetterPlayerService service;
  final LessonPlayerActions act;
  final bool hasNextLesson;

  const LessonQuickActionsBar({
    super.key,
    required this.currentSpeed,
    required this.service,
    required this.act,
    required this.hasNextLesson,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          PlayerQuickActionButton(
            icon: Icons.speed_rounded,
            label: '${currentSpeed}x',
            onTap: () {
              SpeedSelectorSheet.show(
                context,
                currentSpeed: currentSpeed,
                onSpeedSelected: act.setSpeed,
              );
            },
          ),
          SizedBox(width: 8.w),
          PlayerQuickActionButton(
            icon: Icons.picture_in_picture_alt_rounded,
            label: PlayerStrings.pipMode,
            onTap: () => service.enablePictureInPicture(),
          ),
          SizedBox(width: 8.w),
          PlayerQuickActionButton(
            icon: Icons.restart_alt_rounded,
            label: PlayerStrings.replayFromStart,
            onTap: () => service.controller?.seekTo(Duration.zero),
          ),
          if (hasNextLesson) ...[
            SizedBox(width: 8.w),
            PlayerQuickActionButton(
              icon: Icons.skip_next_rounded,
              label: PlayerStrings.nextLesson,
              isPrimary: true,
              onTap: () => act.next(context),
            ),
          ],
        ],
      ),
    );
  }
}
