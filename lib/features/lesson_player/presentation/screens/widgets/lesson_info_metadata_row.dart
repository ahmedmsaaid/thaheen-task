import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class LessonInfoMetadataRow extends StatelessWidget {
  final String formattedDuration;
  final String instructor;

  const LessonInfoMetadataRow({
    super.key,
    required this.formattedDuration,
    required this.instructor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Icon(Icons.access_time_rounded, size: 15, color: colors.textSecondary),
        SizedBox(width: 4.w),
        Text(
          '${PlayerStrings.durationPrefix} $formattedDuration',
          style: AppTextStyles.caption(context),
        ),
        SizedBox(width: 16.w),
        Icon(Icons.person_outline_rounded,
            size: 15, color: colors.textSecondary),
        SizedBox(width: 4.w),
        Text(
          '${PlayerStrings.instructorPrefix} $instructor',
          style: AppTextStyles.caption(context),
        ),
      ],
    );
  }
}
