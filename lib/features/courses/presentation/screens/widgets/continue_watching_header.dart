import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class ContinueWatchingHeader extends StatelessWidget {
  final bool isLivePlaying;
  final String courseTitle;

  const ContinueWatchingHeader({
    super.key,
    required this.isLivePlaying,
    required this.courseTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isLivePlaying) _buildLiveBadge() else _buildDefaultBadge(context),
        const Spacer(),
        if (!isLivePlaying) _buildPlayIcon() else _buildCourseTitle(context),
      ],
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w.w, vertical: 4.h.h),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_circle_filled_rounded, color: Colors.white, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            PlayerStrings.nowPlaying,
            style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w.w, vertical: 4.h.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        AppStrings.continueWatching,
        style: AppTextStyles.caption(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildPlayIcon() {
    return Container(
      width: 36.w,
      height: 36.h,
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
      child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20.sp),
    );
  }

  Widget _buildCourseTitle(BuildContext context) {
    return Flexible(
      child: Text(
        courseTitle,
        style: AppTextStyles.caption(context).copyWith(color: Colors.white.withValues(alpha: 0.8)),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
