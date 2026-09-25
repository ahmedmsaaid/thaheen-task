import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class SplashTitleWidget extends StatelessWidget {
  const SplashTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.appName,
          style: AppTextStyles.h1(context).copyWith(color: colors.primary, fontSize: 36),
        ),
        SizedBox(height: 8.h),
        Text(
          AppStrings.userSubtitle,
          style: AppTextStyles.bodySecondary(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
