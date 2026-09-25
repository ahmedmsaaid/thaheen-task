import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class NextLessonPlayIcon extends StatelessWidget {
  const NextLessonPlayIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 26,
      ),
    );
  }
}
