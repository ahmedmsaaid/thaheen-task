import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CourseStatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const CourseStatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        Icon(icon, size: 20, color: colors.primary),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppTextStyles.bodySemiBold(context).copyWith(fontSize: 14),
        ),
        Text(label, style: AppTextStyles.caption(context)),
      ],
    );
  }
}
