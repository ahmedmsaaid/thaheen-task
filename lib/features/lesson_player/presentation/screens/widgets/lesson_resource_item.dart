import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class LessonResourceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const LessonResourceItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: colors.divider),
        ),
        tileColor: colors.surfaceVariant.withValues(alpha: 0.5),
        leading: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: colors.primary, size: 20),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodySemiBold(context).copyWith(fontSize: 14),
        ),
        subtitle: Text(subtitle, style: AppTextStyles.caption(context)),
        trailing: Icon(
          Icons.download_rounded,
          color: colors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}
