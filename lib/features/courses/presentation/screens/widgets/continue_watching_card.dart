import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/providers/app_providers.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_controller.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/continue_watching_embedded_player.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/continue_watching_header.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/continue_watching_progress.dart';

class ContinueWatchingCard extends ConsumerWidget {
  final ContinueWatchingViewModel viewModel;
  final VoidCallback onTap;

  const ContinueWatchingCard({
    super.key,
    required this.viewModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final playerService = ref.watch(betterPlayerServiceProvider);
    final isCurrent = ModalRoute.of(context)?.isCurrent ?? true;

    final isLivePlaying = isCurrent &&
        playerService.isReady &&
        playerService.currentLessonId == viewModel.lesson.id &&
        playerService.controller != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.primaryDarkNavy,
              colors.primaryDark,
              colors.primary,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.35),
              blurRadius: 18.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContinueWatchingHeader(
                isLivePlaying: isLivePlaying,
                courseTitle: viewModel.course.title,
              ),
              SizedBox(height: 12.h),
              if (isLivePlaying)
                ContinueWatchingEmbeddedPlayer(
                  controller: playerService.controller!,
                  onTap: onTap,
                )
              else ...[
                Text(
                  viewModel.course.title,
                  style: AppTextStyles.caption(context).copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
              ],
              Text(
                viewModel.lesson.title,
                style: AppTextStyles.h3(context)
                    .copyWith(color: Colors.white, fontSize: 16.sp),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12.h),
              ContinueWatchingProgress(
                progressValue: viewModel.progressRatio,
                formattedDuration: viewModel.lesson.formattedDuration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
