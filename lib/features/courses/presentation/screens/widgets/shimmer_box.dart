import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double shimmerValue;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    required this.shimmerValue,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        gradient: LinearGradient(
          begin: Alignment(shimmerValue - 1, 0),
          end: Alignment(shimmerValue + 1, 0),
          colors: [colors.divider, colors.surfaceVariant, colors.divider],
        ),
      ),
    );
  }
}
