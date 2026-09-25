import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_gesture_layer.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/watermark_overlay.dart';

/// Wraps BetterPlayer in LTR Directionality (required to keep seekbar correct
/// in RTL apps), adds gesture layer (volume swipe, horizontal seek, double-tap seek)
/// and watermark overlay above the video.
class BetterPlayerView extends StatelessWidget {
  final BetterPlayerController controller;

  const BetterPlayerView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PlayerGestureLayer(
        controller: controller,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: BetterPlayer(controller: controller),
            ),
            const WatermarkOverlay(text: AppStrings.watermarkUser),
          ],
        ),
      ),
    );
  }
}
