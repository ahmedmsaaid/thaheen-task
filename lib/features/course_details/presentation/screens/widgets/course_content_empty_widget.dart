import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CourseContentEmptyWidget extends StatelessWidget {
  const CourseContentEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w.w, vertical: 32.h.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w.w, vertical: 28.h.h),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: colors.divider.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  color: colors.primaryTint,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.video_library_outlined,
                  size: 36.sp,
                  color: colors.primary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.courseContentEmpty,
                style: AppTextStyles.h3(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.courseContentEmptySubtitle,
                style: AppTextStyles.caption(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
