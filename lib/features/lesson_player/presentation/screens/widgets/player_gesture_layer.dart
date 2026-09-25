import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/gesture_double_tap_badge.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/gesture_volume_hud.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/player_gesture_handler.dart';

class PlayerGestureLayer extends StatefulWidget {
  final BetterPlayerController controller;
  final Widget child;

  const PlayerGestureLayer({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  State<PlayerGestureLayer> createState() => _PlayerGestureLayerState();
}

class _PlayerGestureLayerState extends State<PlayerGestureLayer> {
  late final PlayerGestureHandler _handler;

  @override
  void initState() {
    super.initState();
    _handler = PlayerGestureHandler(
      controller: widget.controller,
      onStateChanged: () {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _handler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final sideW = (w * 0.35).clamp(80.0, 220.0);

        return Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            // Left zone: Vertical volume drag + double-tap rewind
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: sideW,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: _handler.onVerticalDragStart,
                onVerticalDragUpdate: _handler.onVerticalDrag,
                onVerticalDragEnd: _handler.onVerticalDragEnd,
                onDoubleTap: () => _handler.handleDoubleTapSide(isLeft: true),
              ),
            ),
            // Right zone: Vertical volume drag + double-tap forward
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: sideW,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragStart: _handler.onVerticalDragStart,
                onVerticalDragUpdate: _handler.onVerticalDrag,
                onVerticalDragEnd: _handler.onVerticalDragEnd,
                onDoubleTap: () => _handler.handleDoubleTapSide(isLeft: false),
              ),
            ),
            if (_handler.showDoubleTapLeft)
              const GestureDoubleTapBadge(isLeft: true),
            if (_handler.showDoubleTapRight)
              const GestureDoubleTapBadge(isLeft: false),
            if (_handler.showVolumeHud)
              GestureVolumeHud(volume: _handler.volume),
          ],
        );
      },
    );
  }
}
