import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class PlayerQuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const PlayerQuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isPrimary
                ? colors.primary.withValues(alpha: 0.15)
                : colors.surfaceVariant,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isPrimary
                  ? colors.primary.withValues(alpha: 0.5)
                  : colors.divider,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isPrimary ? colors.primary : colors.textPrimary,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTextStyles.captionBold(context).copyWith(
                  color: isPrimary ? colors.primary : colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
