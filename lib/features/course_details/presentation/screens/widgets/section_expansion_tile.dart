import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/course_details/presentation/managers/course_details_controller.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/lesson_list_item.dart';

class SectionExpansionTile extends StatelessWidget {
  final SectionViewModel sectionVM;
  final void Function(LessonViewModel lesson) onLessonTap;

  const SectionExpansionTile({super.key, required this.sectionVM, required this.onLessonTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isDone = sectionVM.isFullyCompleted;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w.w, vertical: 5.h.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: colors.primary.withValues(alpha: 0.04), blurRadius: 8.r, offset: Offset(0, 2.h))],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w.w, vertical: 4.h.h),
          childrenPadding: EdgeInsets.only(bottom: 8.h.h),
          leading: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(color: isDone ? colors.success.withValues(alpha: 0.12) : colors.primaryTint, shape: BoxShape.circle),
            child: Icon(isDone ? Icons.check_circle_rounded : Icons.folder_outlined, color: isDone ? colors.success : colors.primary, size: 20.sp),
          ),
          title: Text(sectionVM.section.title, style: AppTextStyles.sectionTitle(context)),
          subtitle: Text('${sectionVM.completedCount}/${sectionVM.lessons.length} ${AppStrings.lessonsCount}', style: AppTextStyles.caption(context)),
          children: sectionVM.lessons.map((l) => LessonListItem(lessonVM: l, onTap: () => onLessonTap(l))).toList(),
        ),
      ),
    );
  }
}
