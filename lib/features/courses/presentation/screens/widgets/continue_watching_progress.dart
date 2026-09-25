import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class ContinueWatchingProgress extends StatelessWidget {
  final double progressValue;
  final String formattedDuration;

  const ContinueWatchingProgress({
    super.key,
    required this.progressValue,
    required this.formattedDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 5.h,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          '$formattedDuration • ${(progressValue * 100).toInt()}% ${AppStrings.progress}',
          style: AppTextStyles.caption(context).copyWith(color: Colors.white.withValues(alpha: 0.75)),
        ),
      ],
    );
  }
}
