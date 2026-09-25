import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class WatchedEmptyView extends StatelessWidget {
  const WatchedEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_circle_outline_rounded, size: 64.sp, color: colors.textSecondary.withValues(alpha: 0.5)),
            SizedBox(height: 16.h),
            Text(AppStrings.watchedEmpty, style: AppTextStyles.h3(context)),
            SizedBox(height: 8.h),
            Text(AppStrings.watchedEmptySubtitle, style: AppTextStyles.caption(context), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
