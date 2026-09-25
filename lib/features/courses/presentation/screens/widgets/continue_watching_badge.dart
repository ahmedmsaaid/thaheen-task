import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class ContinueWatchingBadge extends StatelessWidget {
  const ContinueWatchingBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            AppStrings.continueWatching,
            style: AppTextStyles.caption(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
        ),
      ],
    );
  }
}
