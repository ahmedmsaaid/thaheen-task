import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class SpeedChip extends StatelessWidget {
  final double speed;
  final bool isSelected;
  final VoidCallback onTap;

  const SpeedChip({
    super.key,
    required this.speed,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.primaryTint,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? colors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          '${speed}x',
          style: AppTextStyles.bodySemiBold(context).copyWith(
            color: isSelected ? Colors.white : colors.primary,
          ),
        ),
      ),
    );
  }
}
