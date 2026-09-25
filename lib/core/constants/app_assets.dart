class AnimationImages {
  AnimationImages._();
  static const animationPath = 'assets/lotties';
}

/// All asset paths centralized — never hard-code paths in widgets.
class AppAssets {
  AppAssets._();

  // ── Lottie Animations ─────────────────────────────────────
  static const loadingLottie = '${AnimationImages.animationPath}/loading_gray.json';

  // ── Data ────────────────────────────────────────────────
  static const coursesJson = 'assets/data/courses.json';

  // ── Images ──────────────────────────────────────────────
  static const appLogo = 'assets/images/png/app_logo.png';
  static const anatomyThumbnail = 'assets/images/anatomy.png';
  static const biostatisticsThumbnail = 'assets/images/biostatistics.png';
  static const pharmacologyThumbnail = 'assets/images/pharmacology.png';

  // ── Videos ──────────────────────────────────────────────
  static const lesson1Video = 'assets/videos/lesson1.mp4';
  static const lesson2Video = 'assets/videos/lesson2.mp4';
  static const lesson3Video = 'assets/videos/lesson3.mp4';
  static const lesson4Video = 'assets/videos/lesson4.mp4';
  static const lesson5Video = 'assets/videos/lesson5.mp4';
  static const lesson6Video = 'assets/videos/lesson6.mp4';
  static const lesson7Video = 'assets/videos/lesson7.mp4';
}

/// All durations used across the app — centralized.
class AppDurations {
  AppDurations._();

  static const controlsAutoHide = Duration(seconds: 3);
  static const snackBarDuration = Duration(seconds: 2);
  static const progressSaveDebounce = Duration(milliseconds: 500);
  static const pageTransition = Duration(milliseconds: 300);
  static const shimmerAnimation = Duration(milliseconds: 1500);
}
