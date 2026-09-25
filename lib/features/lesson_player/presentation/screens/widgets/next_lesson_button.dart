import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/courses/data/models/lesson_model.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/next_lesson_info_column.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/next_lesson_play_icon.dart';

class NextLessonButton extends StatefulWidget {
  final LessonModel nextLesson;
  final VoidCallback onTap;
  const NextLessonButton({super.key, required this.nextLesson, required this.onTap});

  @override
  State<NextLessonButton> createState() => _NextLessonButtonState();
}

class _NextLessonButtonState extends State<NextLessonButton> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _slide = Tween(begin: 40.0, end: 0.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _slide.value),
        child: FadeTransition(opacity: _fade, child: child),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0.h),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primaryDark, colors.primary],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: Offset(0.w, 5.h),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () {
                debugPrint('[NextLessonButton] Clicked: ${widget.nextLesson.id}');
                try {
                  widget.onTap();
                } catch (e, st) {
                  debugPrint('[NextLessonButton] Tap error: $e\n$st');
                }
              },
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Expanded(
                      child: NextLessonInfoColumn(
                        nextLesson: widget.nextLesson,
                        onDarkBg: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    const NextLessonPlayIcon(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
