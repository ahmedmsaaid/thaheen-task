import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/shimmer_course_card.dart';

class CoursesLoadingState extends StatefulWidget {
  const CoursesLoadingState({super.key});

  @override
  State<CoursesLoadingState> createState() => _CoursesLoadingStateState();
}

class _CoursesLoadingStateState extends State<CoursesLoadingState>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => ListView.builder(
        padding: EdgeInsets.only(top: 8.h),
        itemCount: 3,
        itemBuilder: (context, index) =>
            ShimmerCourseCard(shimmerValue: _animation.value),
      ),
    );
  }
}
