import 'package:better_player_plus/better_player_plus.dart';

/// Arabic + English translations for BetterPlayer controls.
class PlayerTranslations {
  static final ar = BetterPlayerTranslations(
    languageCode: 'ar',
    generalDefaultError: 'تعذّر تشغيل الفيديو',
    generalNone: 'بدون',
    generalDefault: 'افتراضي',
    generalRetry: 'إعادة المحاولة',
    playlistLoadingNextVideo: 'جاري تحميل الدرس التالي',
    controlsLive: 'مباشر',
    controlsNextVideoIn: 'الدرس التالي خلال',
    overflowMenuPlaybackSpeed: 'سرعة التشغيل',
    overflowMenuSubtitles: 'الترجمة',
    overflowMenuQuality: 'الجودة',
    overflowMenuAudioTracks: 'الصوت',
    qualityAuto: 'تلقائي',
  );

  static final all = [ar, BetterPlayerTranslations()];
}
