import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HatNavItemLabelWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Duration duration;

  const HatNavItemLabelWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: Curves.easeInOut,
      child: isSelected
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: GoogleFonts.cairo(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
