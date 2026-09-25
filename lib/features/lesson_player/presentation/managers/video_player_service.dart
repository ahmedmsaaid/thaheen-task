import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:thaheen/core/constants/app_assets.dart';
import 'package:thaheen/core/theme/app_colors.dart';

class VideoPlayerService {
  VideoPlayerController? vCtrl;
  ChewieController? cCtrl;
  Timer? _timer;
  String? error;
  bool _isDisposed = false;
  bool get hasError => error != null || (vCtrl?.value.hasError ?? false);

  Future<void> init({
    required String path, required int resumeSec, required double speed,
    required VoidCallback onSave, VoidCallback? onError,
  }) async {
    try {
      dispose();
      _isDisposed = false;
      error = null;
      vCtrl = VideoPlayerController.asset(path);
      await vCtrl!.initialize();
      if (resumeSec > 0) await vCtrl!.seekTo(Duration(seconds: resumeSec));
      await vCtrl!.setPlaybackSpeed(speed);
      cCtrl = ChewieController(
        videoPlayerController: vCtrl!, autoPlay: true, allowFullScreen: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColorsLight.primary, handleColor: AppColorsLight.primary,
          backgroundColor: AppColorsLight.primaryTintSec,
        ),
      );
      _timer = Timer.periodic(AppDurations.progressSaveDebounce, (_) { if (!_isDisposed) onSave(); });
      vCtrl?.addListener(() {
        if (vCtrl?.value.hasError == true && error == null) {
          error = vCtrl?.value.errorDescription ?? 'Video error';
          onError?.call();
        }
      });
    } catch (e) {
      error = e.toString();
      onError?.call();
    }
  }

  void seekBy(int s) {
    final p = vCtrl?.value.position, d = vCtrl?.value.duration;
    if (p == null) return;
    final t = p + Duration(seconds: s);
    vCtrl?.seekTo(t < Duration.zero ? Duration.zero : (d != null && t > d ? d : t));
  }

  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    _timer = null;
    cCtrl?.dispose();
    vCtrl?.dispose();
    cCtrl = null;
    vCtrl = null;
  }
}
