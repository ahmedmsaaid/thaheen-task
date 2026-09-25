import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CoursesEmptyState extends StatelessWidget {
  const CoursesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: colors.primaryTint,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.school_outlined,
              size: 48,
              color: colors.primary,
            ),
          ),
          SizedBox(height: 20.h),
          Text(AppStrings.coursesEmpty, style: AppTextStyles.h2(context)),
          SizedBox(height: 8.h),
          Text(
            AppStrings.coursesEmptySubtitle,
            style: AppTextStyles.bodySecondary(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
