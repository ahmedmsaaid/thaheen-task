import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_assets.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Image.asset(AppAssets.appLogo, fit: BoxFit.contain),
      ),
    );
  }
}
