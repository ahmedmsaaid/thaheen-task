import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

typedef PlayerTabItem = ({String title, IconData icon});

class PlayerSegmentedTabBar extends StatelessWidget {
  final List<PlayerTabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const PlayerSegmentedTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 10.h.h),
                decoration: BoxDecoration(
                  color: isSelected ? colors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4.r,
                            offset: Offset(0, 2.h),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tab.icon,
                      size: 16.sp,
                      color: isSelected ? colors.primary : colors.textSecondary,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      tab.title,
                      style: AppTextStyles.captionBold(context).copyWith(
                        color:
                            isSelected ? colors.primary : colors.textSecondary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
