import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CourseInfoBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const CourseInfoBadge({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 13.sp),
          SizedBox(width: 4.w),
          Text(label, style: AppTextStyles.caption(context).copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 11.sp)),
        ],
      ),
    );
  }
}
