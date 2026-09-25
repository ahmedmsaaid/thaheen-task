import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isArabic = context.locale.languageCode == 'ar';

    return Tooltip(
      message: AppStrings.languageToggleTooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final target = isArabic ? const Locale('en') : const Locale('ar');
            context.setLocale(target);
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: colors.surface.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: colors.divider.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language_rounded,
                  size: 16.sp,
                  color: colors.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  isArabic ? 'EN' : 'عربي',
                  style: AppTextStyles.captionBold(context).copyWith(
                    color: colors.primary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
