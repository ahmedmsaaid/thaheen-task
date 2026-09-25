import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class PlaylistLessonTileSubtitle extends StatelessWidget {
  final String duration;
  final bool isUnlocked;
  final bool isCompleted;

  const PlaylistLessonTileSubtitle({
    super.key,
    required this.duration,
    required this.isUnlocked,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final statusText = !isUnlocked
        ? PlayerStrings.lockedStatus
        : isCompleted
            ? PlayerStrings.completedStatus
            : null;
    final statusColor = !isUnlocked ? colors.locked : colors.success;

    return Row(
      children: [
        Text(
          duration,
          style: AppTextStyles.caption(context).copyWith(
            color: isUnlocked ? colors.textSecondary : colors.locked,
          ),
        ),
        if (statusText != null) ...[
          SizedBox(width: 8.w),
          Text(
            statusText,
            style: AppTextStyles.caption(context).copyWith(
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
