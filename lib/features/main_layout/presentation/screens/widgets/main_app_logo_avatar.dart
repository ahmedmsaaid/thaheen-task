import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_assets.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class MainAppLogoAvatar extends StatelessWidget {
  const MainAppLogoAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: 42.w,
      height: 42.h,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.primary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.15),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(AppAssets.appLogo, fit: BoxFit.contain),
      ),
    );
  }
}
