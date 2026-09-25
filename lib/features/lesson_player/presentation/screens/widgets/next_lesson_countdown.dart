import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class NextLessonCountdown extends StatefulWidget {
  final VoidCallback onAutoNext;
  final VoidCallback onCancel;
  const NextLessonCountdown({super.key, required this.onAutoNext, required this.onCancel});

  @override
  State<NextLessonCountdown> createState() => _State();
}

class _State extends State<NextLessonCountdown> {
  int _secs = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _secs--);
      if (_secs <= 0) {
        _timer?.cancel();
        widget.onAutoNext();
      }
    });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: colors.primaryDarkNavy.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colors.primary.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${AppStrings.autoNextIn} $_secs ${AppStrings.secondsUnit}', style: AppTextStyles.h3(context).copyWith(color: Colors.white)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: widget.onCancel,
                child: Text(AppStrings.cancelButton, style: AppTextStyles.bodySemiBold(context).copyWith(color: colors.textSecondary)),
              ),
              SizedBox(width: 16.w),
              ElevatedButton.icon(
                onPressed: widget.onAutoNext,
                icon: Icon(Icons.play_arrow_rounded, size: 20.sp),
                label: Text(AppStrings.nextLesson, style: AppTextStyles.bodySemiBold(context)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.w.w, vertical: 10.h.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
