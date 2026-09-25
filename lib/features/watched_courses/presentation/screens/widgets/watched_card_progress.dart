import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class WatchedCardProgress extends StatelessWidget {
  final double ratio;
  final bool isCompleted;
  const WatchedCardProgress({super.key, required this.ratio, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final percent = (ratio * 100).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: ratio,
                backgroundColor: colors.surfaceVariant,
                color: isCompleted ? colors.success : colors.primary,
                borderRadius: BorderRadius.circular(8.r),
                minHeight: 5.h,
              ),
            ),
            SizedBox(width: 8.w),
            Text('$percent%', style: AppTextStyles.caption(context).copyWith(color: colors.primary, fontWeight: FontWeight.w700, fontSize: 11.sp)),
          ],
        ),
        if (isCompleted) ...[
          SizedBox(height: 6.h),
          Row(children: [
            Icon(Icons.check_circle_rounded, size: 13.sp, color: colors.success),
            SizedBox(width: 4.w),
            Text(AppStrings.lessonStatusCompleted, style: AppTextStyles.caption(context).copyWith(color: colors.success, fontWeight: FontWeight.w600, fontSize: 11.sp)),
          ]),
        ],
      ],
    );
  }
}
