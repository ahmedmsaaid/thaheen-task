import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class LessonNoteItem extends StatelessWidget {
  final String text;
  final String formattedTime;
  final VoidCallback onSeek;

  const LessonNoteItem({
    super.key,
    required this.text,
    required this.formattedTime,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onSeek,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow_rounded,
                      size: 14, color: colors.primary),
                  SizedBox(width: 2.w),
                  Text(
                    formattedTime,
                    style: AppTextStyles.captionBold(context)
                        .copyWith(color: colors.primary),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyPrimary(context).copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
