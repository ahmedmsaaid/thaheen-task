import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';

class VideoSeekDetectorOverlay extends StatelessWidget {
  final double width;
  final VoidCallback onDoubleTapLeft;
  final VoidCallback onDoubleTapRight;

  const VideoSeekDetectorOverlay({
    super.key,
    required this.width,
    required this.onDoubleTapLeft,
    required this.onDoubleTapRight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Row(
        children: [
          SizedBox(
            width: width / 3,
            child: Semantics(
              label: AppStrings.seekBackwardLabel,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTap: onDoubleTapLeft,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: width / 3,
            child: Semantics(
              label: AppStrings.seekForwardLabel,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTap: onDoubleTapRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
