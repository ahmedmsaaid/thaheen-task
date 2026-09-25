import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/features/lesson_player/domain/progress_calculator.dart';

void main() {
  late ProgressCalculator calculator;

  setUp(() {
    calculator = const ProgressCalculator();
  });

  group('ProgressCalculator - isCompleted (90% Rule)', () {
    test('returns true when watched seconds is exactly 90% of total', () {
      expect(
        calculator.isCompleted(watchedSeconds: 90, totalSeconds: 100),
        isTrue,
      );
    });

    test('returns true when watched 86 of 95 seconds (~90.5%)', () {
      expect(
        calculator.isCompleted(watchedSeconds: 86, totalSeconds: 95),
        isTrue,
      );
    });

    test('returns false when watched less than 90% — 50 of 95 seconds', () {
      expect(
        calculator.isCompleted(watchedSeconds: 50, totalSeconds: 95),
        isFalse,
      );
    });

    test('returns false when watched exactly 89% — 89 of 100 seconds', () {
      expect(
        calculator.isCompleted(watchedSeconds: 89, totalSeconds: 100),
        isFalse,
      );
    });

    test('returns true when watched 100% — all of total seconds', () {
      expect(
        calculator.isCompleted(watchedSeconds: 120, totalSeconds: 120),
        isTrue,
      );
    });

    test('returns false when totalSeconds is zero — avoids division by zero',
        () {
      expect(
        calculator.isCompleted(watchedSeconds: 0, totalSeconds: 0),
        isFalse,
      );
    });

    test('returns false when watchedSeconds is zero', () {
      expect(
        calculator.isCompleted(watchedSeconds: 0, totalSeconds: 100),
        isFalse,
      );
    });
  });

  group('ProgressCalculator - courseCompletionPercentage', () {
    test('returns 0.5 when 2 of 4 lessons completed', () {
      expect(
        calculator.courseCompletionPercentage(
            totalLessons: 4, completedLessons: 2),
        equals(0.5),
      );
    });

    test('returns 0.0 for empty course — avoids division by zero', () {
      expect(
        calculator.courseCompletionPercentage(
            totalLessons: 0, completedLessons: 0),
        equals(0.0),
      );
    });

    test('returns 1.0 when all lessons completed', () {
      expect(
        calculator.courseCompletionPercentage(
            totalLessons: 5, completedLessons: 5),
        equals(1.0),
      );
    });

    test('returns 0.0 when no lessons completed', () {
      expect(
        calculator.courseCompletionPercentage(
            totalLessons: 3, completedLessons: 0),
        equals(0.0),
      );
    });

    test('clamps to 1.0 even if completedLessons > totalLessons', () {
      expect(
        calculator.courseCompletionPercentage(
            totalLessons: 3, completedLessons: 10),
        equals(1.0),
      );
    });
  });

  group('ProgressCalculator - watchPercentage', () {
    test('returns 0.5 for half-watched lesson', () {
      expect(
        calculator.watchPercentage(watchedSeconds: 50, totalSeconds: 100),
        equals(0.5),
      );
    });

    test('clamps to 1.0 even if watched exceeds total', () {
      expect(
        calculator.watchPercentage(watchedSeconds: 150, totalSeconds: 100),
        equals(1.0),
      );
    });

    test('returns 0.0 for zero total duration', () {
      expect(
        calculator.watchPercentage(watchedSeconds: 0, totalSeconds: 0),
        equals(0.0),
      );
    });
  });
}
