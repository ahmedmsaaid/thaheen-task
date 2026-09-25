import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/core/utils/app_toast.dart';

class PlayerAppBar extends StatelessWidget {
  final String courseTitle;
  final String lessonTitle;
  final VoidCallback onBackPressed;

  const PlayerAppBar({
    super.key,
    required this.courseTitle,
    required this.lessonTitle,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SliverAppBar(
      pinned: true,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: Center(
        child: Container(
          margin: EdgeInsets.only(right: 12.w),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.divider),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            padding: EdgeInsets.zero,
            onPressed: onBackPressed,
            tooltip: AppStrings.closeButton,
          ),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            courseTitle,
            style: AppTextStyles.caption(context).copyWith(
              color: colors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h),
          Text(
            lessonTitle,
            style: AppTextStyles.h3(context).copyWith(fontSize: 14, fontWeight: FontWeight.w800),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        Center(
          child: Container(
            margin: EdgeInsets.only(left: 12.w),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.divider),
            ),
            child: IconButton(
              icon: const Icon(Icons.share_outlined, size: 18),
              padding: EdgeInsets.zero,
              onPressed: () => AppToast.showSuccess(context, message: PlayerStrings.shareLessonSuccess),
              tooltip: PlayerStrings.shareTooltip,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: colors.divider, height: 1),
      ),
    );
  }
}
