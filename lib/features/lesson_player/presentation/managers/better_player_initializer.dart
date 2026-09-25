import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_config_builder.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_controls.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_data_source_builder.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_event_binder.dart';

class BetterPlayerInitializer {
  const BetterPlayerInitializer._();

  static Future<BetterPlayerController> create({
    required String assetPath,
    required int resumeSec,
    required double speed,
    String? title,
    String? author,
    required bool Function() isDisposed,
    required void Function(bool isPlaying) onPlayStateChanged,
    required VoidCallback onFinished,
    required VoidCallback onError,
    required VoidCallback safeNotify,
  }) async {
    BetterPlayerController? ctrl;
    final config = BetterPlayerConfigBuilder.build(
      resumeSec: resumeSec,
      onSeekBy: (sec) => BetterPlayerControls.seekBy(ctrl, sec),
      onReplayStart: () => ctrl?.seekTo(Duration.zero),
      onToggleMute: () {
        final v = ctrl?.videoPlayerController?.value.volume ?? 1.0;
        BetterPlayerControls.setVolume(ctrl, v > 0 ? 0.0 : 1.0);
      },
    );

    final dataSource = await BetterPlayerDataSourceBuilder.build(
      assetPath: assetPath,
      title: title,
      author: author,
    );

    ctrl = BetterPlayerController(config, betterPlayerDataSource: dataSource);
    ctrl.setupTranslations(const Locale('ar'));
    ctrl.setControlsEnabled(true);
    ctrl.setSpeed(speed);

    BetterPlayerEventBinder.bindEvents(
      controller: ctrl,
      isDisposed: isDisposed,
      onPlayStateChanged: onPlayStateChanged,
      onFinished: onFinished,
      onError: onError,
      safeNotify: safeNotify,
    );

    return ctrl;
  }
}
