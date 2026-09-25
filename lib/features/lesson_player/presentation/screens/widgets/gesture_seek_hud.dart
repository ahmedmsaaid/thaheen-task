import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors_dark.dart';

class GestureSeekHud extends StatelessWidget {
  final int seekOffsetSec;
  final int targetPositionSec;

  const GestureSeekHud({
    super.key,
    required this.seekOffsetSec,
    required this.targetPositionSec,
  });

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColorsDark.primaryLight),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                seekOffsetSec >= 0
                    ? Icons.fast_forward_rounded
                    : Icons.fast_rewind_rounded,
                color: AppColorsDark.primaryLight,
                size: 34,
              ),
              SizedBox(height: 6.h),
              Text(
                '${seekOffsetSec >= 0 ? '+' : ''}$seekOffsetSec ${AppStrings.secondsUnit}',
                style: const TextStyle(
                  color: AppColorsDark.primaryLight,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                _formatDuration(targetPositionSec),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
