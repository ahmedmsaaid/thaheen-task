import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';

class CourseDetailsAppBar extends StatelessWidget {
  final Course course;

  const CourseDetailsAppBar({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return SliverAppBar(
      expandedHeight: 220.h,
      pinned: true,
      backgroundColor: colors.primaryDarkNavy,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              course.thumbnail,
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
                  child: Icon(Icons.school_rounded, size: 72.sp, color: Colors.white.withValues(alpha: 0.6)),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, colors.primaryDarkNavy.withValues(alpha: 0.8)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
