import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class LockedSheetIcon extends StatelessWidget {
  const LockedSheetIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: 72.w,
      height: 72.h,
      decoration: BoxDecoration(
        color: colors.locked.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.lock_rounded, color: colors.locked, size: 32.sp),
    );
  }
}
