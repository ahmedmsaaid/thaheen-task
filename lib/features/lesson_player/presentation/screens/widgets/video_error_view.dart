import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class VideoErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const VideoErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam_off_rounded, size: 42, color: colors.error),
            SizedBox(height: 8.h),
            Text(
              AppStrings.videoLoadError,
              style: AppTextStyles.h3(context).copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            Text(
              AppStrings.videoLoadErrorSubtitle,
              style: AppTextStyles.caption(context)
                  .copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(AppStrings.retryButton),
            ),
          ],
        ),
      ),
    );
  }
}
