import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/next_lesson_prompt_data.dart';

class NextLessonPromptButtons extends StatelessWidget {
  final NextLessonPromptData data;
  final VoidCallback onDismiss;

  const NextLessonPromptButtons({
    super.key,
    required this.data,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDismiss();
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              side: BorderSide(color: colors.primary.withValues(alpha: 0.3)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(
              AppStrings.playLaterButton,
              style: AppTextStyles.bodySecondary(context),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              final router = GoRouter.of(context);
              Navigator.of(context).pop();
              onDismiss();
              router.push(AppRouter.lessonPlayerPath(data.courseId, data.nextLesson.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(
              AppStrings.playNextLessonButton,
              style: AppTextStyles.buttonPrimary(context),
            ),
          ),
        ),
      ],
    );
  }
}
