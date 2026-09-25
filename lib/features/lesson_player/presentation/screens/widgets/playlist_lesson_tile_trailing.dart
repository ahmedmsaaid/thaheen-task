import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class PlaylistLessonTileTrailing extends StatelessWidget {
  final bool isActive;
  final bool isUnlocked;
  final bool isCompleted;

  const PlaylistLessonTileTrailing({
    super.key,
    required this.isActive,
    required this.isUnlocked,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    if (isActive) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Text(
          PlayerStrings.playingNow,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    if (!isUnlocked) {
      return Icon(Icons.lock_outline_rounded, color: colors.locked, size: 20);
    }
    if (isCompleted) {
      return Icon(Icons.check_circle_rounded, color: colors.success, size: 22);
    }
    return Icon(Icons.play_circle_outline_rounded,
        color: colors.primary, size: 22);
  }
}
