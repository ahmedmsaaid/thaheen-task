import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors_dark.dart';
import 'package:thaheen/core/widgets/custom_loading_indicator_widget.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/player_translations.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/watermark_overlay.dart';

class BetterPlayerConfigBuilder {
  const BetterPlayerConfigBuilder._();

  static BetterPlayerConfiguration build({
    required int resumeSec,
    required void Function(int seconds) onSeekBy,
    required VoidCallback onReplayStart,
    required VoidCallback onToggleMute,
  }) {
    return BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: true,
      startAt: Duration(seconds: resumeSec),
      handleLifecycle: false,
      autoDispose: false,
      looping: false,
      translations: PlayerTranslations.all,
      overlay:  Stack(
        fit: StackFit.expand,
        children: [WatermarkOverlay(text: AppStrings.watermarkUser)],
      ),
      subtitlesConfiguration: const BetterPlayerSubtitlesConfiguration(
        fontFamily: 'Cairo',
        fontSize: 18,
        fontColor: Colors.white,
        backgroundColor: AppColorsDark.overlay,
        outlineEnabled: true,
      ),
      controlsConfiguration: BetterPlayerControlsConfiguration(
        loadingWidget: const CustomLoadingIndicatorWidget(size: 64),
        enablePlaybackSpeed: true,
        enableSubtitles: false,
        enableQualities: false,
        enableAudioTracks: false,
        enablePip: true,
        enableSkips: true,
        enablePlayPause: true,
        skipBackIcon: Icons.replay_10_rounded,
        skipForwardIcon: Icons.forward_10_rounded,
        pipMenuIcon: Icons.picture_in_picture_alt_rounded,
        forwardSkipTimeInMilliseconds: 10000,
        backwardSkipTimeInMilliseconds: 10000,
        enableProgressBarDrag: true,
        enableFullscreen: true,
        overflowMenuIcon: Icons.more_vert_rounded,
        overflowMenuIconsColor: AppColorsDark.primaryLight,
        overflowModalColor: AppColorsDark.primaryDarkNavy,
        overflowModalTextColor: Colors.white,
        iconsColor: Colors.white,
        progressBarPlayedColor: AppColorsDark.primaryLight,
        progressBarHandleColor: AppColorsDark.primaryLight,
        progressBarBufferedColor: Colors.white24,
        progressBarBackgroundColor: Colors.white10,
        overflowMenuCustomItems: [
          BetterPlayerOverflowMenuItem(
            Icons.replay_10_rounded,
            PlayerStrings.rewind10Sec,
            () => onSeekBy(-10),
          ),
          BetterPlayerOverflowMenuItem(
            Icons.forward_10_rounded,
            PlayerStrings.forward10Sec,
            () => onSeekBy(10),
          ),
          BetterPlayerOverflowMenuItem(
            Icons.restart_alt_rounded,
            PlayerStrings.replayFromStartMenu,
            onReplayStart,
          ),
          BetterPlayerOverflowMenuItem(
            Icons.volume_up_rounded,
            PlayerStrings.toggleMuteMenu,
            onToggleMute,
          ),
        ],
      ),
    );
  }
}
