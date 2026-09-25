import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/next_lesson_prompt_data.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/next_lesson_prompt_buttons.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/next_lesson_prompt_preview_card.dart';

class NextLessonPromptSheet extends StatelessWidget {
  final NextLessonPromptData data;
  final VoidCallback onDismiss;

  const NextLessonPromptSheet({
    super.key,
    required this.data,
    required this.onDismiss,
  });

  static Future<void> show(
    BuildContext context, {
    required NextLessonPromptData data,
    required VoidCallback onDismiss,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => NextLessonPromptSheet(data: data, onDismiss: onDismiss),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: colors.overlay.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: colors.textSecondary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text(AppStrings.nextLessonPromptTitle, style: AppTextStyles.h2(context)),
          SizedBox(height: 6.h),
          Text(
            AppStrings.nextLessonPromptSubtitle,
            style: AppTextStyles.bodySecondary(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14.h),
          NextLessonPromptPreviewCard(
            nextLesson: data.nextLesson,
            onTap: () {
              final router = GoRouter.of(context);
              Navigator.of(context).pop();
              onDismiss();
              router.push(AppRouter.lessonPlayerPath(data.courseId, data.nextLesson.id));
            },
          ),
          SizedBox(height: 18.h),
          NextLessonPromptButtons(data: data, onDismiss: onDismiss),
        ],
      ),
    );
  }
}
