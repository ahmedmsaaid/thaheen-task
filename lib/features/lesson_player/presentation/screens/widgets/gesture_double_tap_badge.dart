import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';

class GestureDoubleTapBadge extends StatelessWidget {
  final bool isLeft;

  const GestureDoubleTapBadge({super.key, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isLeft ? 32 : null,
      right: isLeft ? null : 32,
      top: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLeft) ...[
                  const Icon(Icons.replay_10_rounded,
                      color: Colors.white, size: 28),
                  SizedBox(width: 8.w),
                   Text(
                    '10- ${AppStrings.secondsUnit}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                   Text(
                    '10+ ${AppStrings.secondsUnit}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const Icon(Icons.forward_10_rounded,
                      color: Colors.white, size: 28),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
