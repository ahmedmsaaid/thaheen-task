class ProgressCalculator {
  const ProgressCalculator();

  static const double _completionThreshold = 0.9;

  bool isCompleted({
    required int watchedSeconds,
    required int totalSeconds,
  }) {
    if (totalSeconds <= 0) return false;
    return watchedSeconds / totalSeconds >= _completionThreshold;
  }

  double watchPercentage({
    required int watchedSeconds,
    required int totalSeconds,
  }) {
    if (totalSeconds <= 0) return 0.0;
    return (watchedSeconds / totalSeconds).clamp(0.0, 1.0);
  }

  double courseCompletionPercentage({
    required int totalLessons,
    required int completedLessons,
  }) {
    if (totalLessons <= 0) return 0.0;
    return (completedLessons / totalLessons).clamp(0.0, 1.0);
  }
}
