import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CoursesSectionHeader extends StatelessWidget {
  const CoursesSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 4.h),
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: 22.h,
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 10.w),
            Text(AppStrings.coursesTitle, style: AppTextStyles.h2(context)),
          ],
        ),
      ),
    );
  }
}
