import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/main_bottom_nav_items_row.dart';

class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        child: Center(
          heightFactor: 1.0,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  height: 68.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: colors.isDark ? 0.85 : 0.94),
                    borderRadius: BorderRadius.circular(32.r),
                    border: Border.all(
                      color: colors.divider.withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: colors.isDark ? 0.3 : 0.08),
                        blurRadius: 16.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: MainBottomNavItemsRow(
                    currentIndex: currentIndex,
                    onTabSelected: onTabSelected,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
