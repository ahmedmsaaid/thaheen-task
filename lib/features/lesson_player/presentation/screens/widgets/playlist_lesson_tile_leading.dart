import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class PlaylistLessonTileLeading extends StatelessWidget {
  final int displayIndex;
  final bool isActive;
  final bool isUnlocked;
  final bool isCompleted;

  const PlaylistLessonTileLeading({
    super.key,
    required this.displayIndex,
    required this.isActive,
    required this.isUnlocked,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive
            ? colors.primary
            : !isUnlocked
                ? colors.locked.withValues(alpha: 0.1)
                : isCompleted
                    ? colors.success.withValues(alpha: 0.12)
                    : colors.surfaceVariant,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isActive
            ? const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20)
            : !isUnlocked
                ? Icon(Icons.lock_rounded, color: colors.locked, size: 18)
                : isCompleted
                    ? Icon(Icons.check_rounded, color: colors.success, size: 18)
                    : Text(
                        '$displayIndex',
                        style: AppTextStyles.captionBold(context).copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
      ),
    );
  }
}
