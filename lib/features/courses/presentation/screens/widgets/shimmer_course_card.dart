import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/shimmer_box.dart';

class ShimmerCourseCard extends StatelessWidget {
  final double shimmerValue;

  const ShimmerCourseCard({super.key, required this.shimmerValue});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w.w, vertical: 6.h.h),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(18.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
            child: ShimmerBox(height: 160.h, width: double.infinity, shimmerValue: shimmerValue),
          ),
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(height: 18.h, width: 200.w, shimmerValue: shimmerValue),
                SizedBox(height: 8.h),
                ShimmerBox(height: 13.h, width: 130.w, shimmerValue: shimmerValue),
                SizedBox(height: 10.h),
                ShimmerBox(height: 6.h, width: double.infinity, shimmerValue: shimmerValue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
