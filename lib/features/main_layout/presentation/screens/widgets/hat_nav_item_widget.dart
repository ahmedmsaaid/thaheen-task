import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/hat_nav_item_label_widget.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/nav_item_data.dart';

class HatNavItemWidget extends StatelessWidget {
  final NavItemData item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveBgColor;
  final Color inactiveIconColor;

  const HatNavItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
    required this.inactiveBgColor,
    required this.inactiveIconColor,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    final pad = isSelected
        ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h)
        : EdgeInsets.all(10.r);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.easeInOut,
        padding: pad,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : inactiveBgColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.35),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.selectedIcon : item.icon,
              color: isSelected ? Colors.white : inactiveIconColor,
              size: 22.sp,
            ),
            HatNavItemLabelWidget(
              label: item.label,
              isSelected: isSelected,
              duration: duration,
            ),
          ],
        ),
      ),
    );
  }
}
