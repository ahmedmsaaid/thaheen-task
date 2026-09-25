import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_card_content.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_card_header.dart';

export 'package:thaheen/features/courses/presentation/screens/widgets/course_card_content.dart';
export 'package:thaheen/features/courses/presentation/screens/widgets/course_card_header.dart';
export 'package:thaheen/features/courses/presentation/screens/widgets/course_progress_bar.dart';

class CourseListItem extends StatelessWidget {
  final CourseViewModel viewModel;
  final VoidCallback onTap;

  const CourseListItem({super.key, required this.viewModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w.w, vertical: 8.h.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: colors.isDark
                  ? Colors.black.withValues(alpha: 0.25)
                  : colors.primary.withValues(alpha: 0.08),
              blurRadius: 16.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CourseCardHeader(course: viewModel.course),
            CourseCardContent(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}
