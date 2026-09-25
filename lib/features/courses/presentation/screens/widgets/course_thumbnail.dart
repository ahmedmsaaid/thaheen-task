import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class CourseThumbnail extends StatelessWidget {
  final String imagePath;

  const CourseThumbnail({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SizedBox(
      height: 160.h,
      width: double.infinity,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primaryDarkNavy, colors.primary],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child: Icon(Icons.school_rounded, size: 48.sp, color: Colors.white.withValues(alpha: 0.7)),
          ),
        ),
      ),
    );
  }
}
