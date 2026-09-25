import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/core/utils/app_toast.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_resource_item.dart';

class LessonResourcesCard extends StatelessWidget {
  const LessonResourcesCard({super.key});

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
              Icon(Icons.attach_file_rounded, color: colors.primary, size: 20),
              SizedBox(width: 8.w),
              Text(
                PlayerStrings.attachmentsAndResources,
                style: AppTextStyles.h3(context),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          LessonResourceItem(
            icon: Icons.picture_as_pdf_rounded,
            title: PlayerStrings.lessonSummaryPdf,
            subtitle: PlayerStrings.lessonSummarySubtitle,
            onTap: () => AppToast.showSuccess(
              context,
              message: PlayerStrings.downloadingFile,
            ),
          ),
          LessonResourceItem(
            icon: Icons.code_rounded,
            title: PlayerStrings.sourceCode,
            subtitle: PlayerStrings.sourceCodeSubtitle,
            onTap: () => AppToast.showSuccess(
              context,
              message: PlayerStrings.openingCode,
            ),
          ),
          LessonResourceItem(
            icon: Icons.link_rounded,
            title: PlayerStrings.extraReferences,
            subtitle: PlayerStrings.extraReferencesSubtitle,
            onTap: () => AppToast.showSuccess(
              context,
              message: PlayerStrings.openingLinks,
            ),
          ),
        ],
      ),
    );
  }
}
