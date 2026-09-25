import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/widgets/custom_loading_indicator_widget.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/better_player_view.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/video_error_view.dart';

class VideoPlayerSection extends StatelessWidget {
  final BetterPlayerController? betterController;
  final Key? playerKey;
  final bool hasError;
  final VoidCallback onRetry;

  const VideoPlayerSection({
    super.key,
    required this.betterController,
    this.playerKey,
    required this.hasError,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width * 9 / 16;

    if (hasError) {
      return Container(
        height: height,
        color: Colors.black,
        child: VideoErrorView(onRetry: onRetry),
      );
    }

    if (betterController == null) {
      return Container(
        height: height,
        color: Colors.black,
        child: const CustomLoadingIndicatorWidget(),
      );
    }

    return BetterPlayerView(
      controller: betterController!,
      playerKey: playerKey,
    );
  }
}
