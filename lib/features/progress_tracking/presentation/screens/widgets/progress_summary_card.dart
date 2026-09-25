import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class ProgressSummaryCard extends StatelessWidget {
  final double overallRatio;

  const ProgressSummaryCard({super.key, required this.overallRatio});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final percent = (overallRatio * 100).toInt();

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primaryDarkNavy, colors.primaryDark, colors.primary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [BoxShadow(color: colors.primary.withValues(alpha: 0.3), blurRadius: 16.r, offset: Offset(0, 6.h))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.totalProgress, style: AppTextStyles.caption(context).copyWith(color: Colors.white70)),
                SizedBox(height: 6.h),
                Text('$percent%', style: AppTextStyles.h1(context).copyWith(color: Colors.white, fontSize: 32.sp)),
                SizedBox(height: 6.h),
                Text(AppStrings.keepGoing, style: AppTextStyles.bodyPrimary(context).copyWith(color: Colors.white)),
              ],
            ),
          ),
          SizedBox(
            width: 72.w,
            height: 72.h,
            child: CircularProgressIndicator(value: overallRatio, strokeWidth: 8.w, backgroundColor: Colors.white24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
