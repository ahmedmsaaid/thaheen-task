import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors_dark.dart';

class GestureVolumeHud extends StatelessWidget {
  final double volume;

  const GestureVolumeHud({super.key, required this.volume});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white24),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45, blurRadius: 10.r, spreadRadius: 2.r),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                volume == 0
                    ? Icons.volume_off_rounded
                    : volume < 0.5
                        ? Icons.volume_down_rounded
                        : Icons.volume_up_rounded,
                color: Colors.white,
                size: 32.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                '${PlayerStrings.volumeLabel} ${(volume * 100).round()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(width: 120.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: volume,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColorsDark.primaryLight,
                    ),
                    minHeight: 6.h,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
