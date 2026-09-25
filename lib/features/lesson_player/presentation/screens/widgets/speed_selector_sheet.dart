import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/speed_chips_wrap.dart';

class SpeedSelectorSheet extends StatelessWidget {
  final double currentSpeed;
  final void Function(double speed) onSpeedSelected;

  const SpeedSelectorSheet({
    super.key,
    required this.currentSpeed,
    required this.onSpeedSelected,
  });

  static void show(BuildContext context, {required double currentSpeed, required void Function(double) onSpeedSelected}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SpeedSelectorSheet(currentSpeed: currentSpeed, onSpeedSelected: onSpeedSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: colors.divider, borderRadius: BorderRadius.circular(2.r))),
          SizedBox(height: 20.h),
          Text(AppStrings.playbackSpeed, style: AppTextStyles.h3(context)),
          SizedBox(height: 16.h),
          SpeedChipsWrap(currentSpeed: currentSpeed, onSpeedSelected: onSpeedSelected),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
