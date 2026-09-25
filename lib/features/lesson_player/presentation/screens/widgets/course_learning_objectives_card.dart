import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CourseLearningObjectivesCard extends StatelessWidget {
  const CourseLearningObjectivesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.stars_rounded, color: colors.accentGold, size: 20),
              SizedBox(width: 8.w),
              Text(
                PlayerStrings.whatYouWillLearn,
                style: AppTextStyles.h3(context),
              ),
            ],
          ),
          SizedBox(height: 12.h),
           _LearningPoint(text: PlayerStrings.learningObjective1),
           _LearningPoint(text: PlayerStrings.learningObjective2),
           _LearningPoint(text: PlayerStrings.learningObjective3),
        ],
      ),
    );
  }
}

class _LearningPoint extends StatelessWidget {
  final String text;

  const _LearningPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline_rounded,
              size: 18, color: colors.success),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text, style: AppTextStyles.bodySecondary(context)),
          ),
        ],
      ),
    );
  }
}
