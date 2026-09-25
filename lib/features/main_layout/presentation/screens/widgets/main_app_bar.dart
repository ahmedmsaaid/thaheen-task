import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/widgets/responsive_center.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/main_app_logo_avatar.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/theme_toggle_button.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/user_app_bar_greeting.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(74.h);

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.primaryDarkNavy, colors.primaryDark],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: colors.primaryDarkNavy.withValues(alpha: 0.3),
            blurRadius: 14.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w.w, vertical: 8.h.h),
          child: ResponsiveCenter(
            maxWidth: 900.w,
            child: Row(
              children: [
                const MainAppLogoAvatar(),
                SizedBox(width: 12.w),
                const Expanded(child: UserAppBarGreeting()),
                const ThemeToggleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
