import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/hat_nav_item_widget.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/nav_item_data.dart';

class MainBottomNavItemsRow extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const MainBottomNavItemsRow({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  List<NavItemData> get _items => [
    NavItemData(
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book_rounded,
      label: AppStrings.navCourses,
    ),
    NavItemData(
      icon: Icons.play_circle_outline_rounded,
      selectedIcon: Icons.play_circle_rounded,
      label: AppStrings.navWatched,
    ),
    NavItemData(
      icon: Icons.insights_outlined,
      selectedIcon: Icons.insights_rounded,
      label: AppStrings.navProgress,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(_items.length, (index) {
        return HatNavItemWidget(
          item: _items[index],
          isSelected: currentIndex == index,
          onTap: () => onTabSelected(index),
          activeColor: colors.primary,
          inactiveBgColor: colors.surfaceVariant.withValues(alpha: 0.7),
          inactiveIconColor: colors.textSecondary,
        );
      }),
    );
  }
}
