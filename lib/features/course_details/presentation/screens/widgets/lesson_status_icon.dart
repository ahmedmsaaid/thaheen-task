import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/course_details/presentation/managers/course_details_controller.dart';

class LessonStatusIcon extends StatelessWidget {
  final LessonStatus status;

  const LessonStatusIcon({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    switch (status) {
      case LessonStatus.completed:
        return _iconBox(colors.success.withValues(alpha: 0.12), Icons.check_circle_rounded, colors.success, 20.sp);
      case LessonStatus.inProgress:
        return _iconBox(colors.primary.withValues(alpha: 0.12), Icons.play_circle_filled_rounded, colors.primary, 20.sp);
      case LessonStatus.locked:
        return _iconBox(colors.locked.withValues(alpha: 0.1), Icons.lock_rounded, colors.locked, 18.sp);
      case LessonStatus.notStarted:
        return _iconBox(colors.primaryTint, Icons.play_arrow_rounded, colors.primary, 20.sp);
    }
  }

  Widget _iconBox(Color bg, IconData icon, Color iconColor, double size) {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: size),
    );
  }
}
