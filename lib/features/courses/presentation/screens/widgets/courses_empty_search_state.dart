import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';

class CoursesEmptySearchState extends ConsumerWidget {
  const CoursesEmptySearchState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 48.sp,
                color: colors.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppStrings.noSearchResultsTitle,
              style: AppTextStyles.h3(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h),
            Text(
              AppStrings.noSearchResultsSubtitle,
              style: AppTextStyles.bodySecondary(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            TextButton.icon(
              onPressed: () =>
                  ref.read(courseSearchQueryProvider.notifier).state = '',
              icon: Icon(Icons.refresh_rounded, size: 18.sp),
              label: Text(
                AppStrings.clearSearch,
                style: AppTextStyles.captionBold(context).copyWith(
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
