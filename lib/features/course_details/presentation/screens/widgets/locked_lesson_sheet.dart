import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/locked_sheet_icon.dart';

class LockedLessonSheet extends StatelessWidget {
  final String lessonTitle;

  const LockedLessonSheet({super.key, required this.lessonTitle});

  static void show(BuildContext context, String lessonTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LockedLessonSheet(lessonTitle: lessonTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: colors.divider, borderRadius: BorderRadius.circular(2.r))),
          SizedBox(height: 20.h),
          const LockedSheetIcon(),
          SizedBox(height: 14.h),
          Text(AppStrings.lessonLockedTitle, style: AppTextStyles.h2(context)),
          SizedBox(height: 6.h),
          Text(lessonTitle, style: AppTextStyles.bodySecondary(context), textAlign: TextAlign.center),
          SizedBox(height: 4.h),
          Text(AppStrings.lessonLockedDescription, style: AppTextStyles.bodySemiBold(context).copyWith(color: colors.locked), textAlign: TextAlign.center),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(backgroundColor: colors.primary, padding: EdgeInsets.symmetric(vertical: 14.h)),
              child: Text(AppStrings.ok, style: AppTextStyles.buttonPrimary(context)),
            ),
          ),
        ],
      ),
    );
  }
}
