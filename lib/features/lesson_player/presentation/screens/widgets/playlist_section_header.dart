import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class PlaylistSectionHeader extends StatelessWidget {
  final String title;
  final int lessonsCount;

  const PlaylistSectionHeader({
    super.key,
    required this.title,
    required this.lessonsCount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.folder_open_rounded, size: 18, color: colors.primary),
          SizedBox(width: 8.w),
          Text(title, style: AppTextStyles.sectionTitle(context)),
          const Spacer(),
          Text(
            '$lessonsCount ${PlayerStrings.lessonsCountSuffix}',
            style: AppTextStyles.caption(context),
          ),
        ],
      ),
    );
  }
}
