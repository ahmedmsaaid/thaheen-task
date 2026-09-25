import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class CoursesAppBar extends StatelessWidget {
  const CoursesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SliverAppBar(
      pinned: true,
      expandedHeight: 110,
      backgroundColor: colors.background,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: colors.divider,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 14),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.appName,
              style: AppTextStyles.caption(context).copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
            Text(AppStrings.coursesTitle, style: AppTextStyles.h2(context)),
          ],
        ),
      ),
    );
  }
}
