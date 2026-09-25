import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class ProgressStatBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const ProgressStatBox({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w.w, vertical: 16.h.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colors.divider),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.sp),
            SizedBox(height: 8.h),
            Text(value, style: AppTextStyles.h2(context)),
            SizedBox(height: 4.h),
            Text(title, style: AppTextStyles.caption(context), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
