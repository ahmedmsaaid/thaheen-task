import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';

class CoursesSearchBar extends ConsumerStatefulWidget {
  const CoursesSearchBar({super.key});

  @override
  ConsumerState<CoursesSearchBar> createState() => _CoursesSearchBarState();
}

class _CoursesSearchBarState extends ConsumerState<CoursesSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(courseSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final query = ref.watch(courseSearchQueryProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: query.isNotEmpty
                ? colors.primary
                : colors.divider.withValues(alpha: 0.6),
            width: query.isNotEmpty ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.primaryDarkNavy.withValues(alpha: 0.05),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          onChanged: (val) =>
              ref.read(courseSearchQueryProvider.notifier).state = val,
          style: AppTextStyles.bodyPrimary(context),
          decoration: InputDecoration(
            hintText: AppStrings.searchCoursesHint,
            hintStyle: AppTextStyles.caption(context).copyWith(
              color: colors.textSecondary.withValues(alpha: 0.7),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: query.isNotEmpty ? colors.primary : colors.textSecondary,
              size: 22.sp,
            ),
            suffixIcon: query.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: colors.textSecondary,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      _controller.clear();
                      ref.read(courseSearchQueryProvider.notifier).state = '';
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ),
    );
  }
}

