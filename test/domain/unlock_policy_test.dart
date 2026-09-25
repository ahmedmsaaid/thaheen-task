import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/features/courses/data/models/lesson_model.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';
import 'package:thaheen/features/lesson_player/domain/unlock_policy.dart';

Map<String, LessonProgressModel> _buildProgressMap({
  required String courseId,
  required Map<String, bool> lessonCompletions,
}) {
  final result = <String, LessonProgressModel>{};
  lessonCompletions.forEach((lessonId, isCompleted) {
    result[lessonId] = LessonProgressModel(
      lessonId: lessonId,
      courseId: courseId,
      watchedSeconds: isCompleted ? 100 : 50,
      isCompleted: isCompleted,
      lastWatched: DateTime.now(),
    );
  });
  return result;
}

const _courseId = 'test-course';

LessonModel _lesson(String id) => LessonModel(
      id: id,
      title: 'Lesson $id',
      durationSec: 100,
      videoPath: 'assets/videos/test.mp4',
    );

void main() {
  late UnlockPolicy unlockPolicy;

  setUp(() {
    unlockPolicy = const UnlockPolicy();
  });

  final lessons = [
    _lesson('l1'),
    _lesson('l2'),
    _lesson('l3'),
    _lesson('l4'),
  ];

  group('UnlockPolicy - isLessonUnlocked', () {
    test('first lesson is always unlocked regardless of progress', () {
      expect(
        unlockPolicy.isLessonUnlocked(
          lesson: lessons[0],
          allLessons: lessons,
          progressMap: {},
        ),
        isTrue,
      );
    });

    test('second lesson is locked if first lesson not completed', () {
      final progressMap = _buildProgressMap(
        courseId: _courseId,
        lessonCompletions: {'l1': false},
      );
      expect(
        unlockPolicy.isLessonUnlocked(
          lesson: lessons[1],
          allLessons: lessons,
          progressMap: progressMap,
        ),
        isFalse,
      );
    });

    test('second lesson is unlocked if first lesson is completed', () {
      final progressMap = _buildProgressMap(
        courseId: _courseId,
        lessonCompletions: {'l1': true},
      );
      expect(
        unlockPolicy.isLessonUnlocked(
          lesson: lessons[1],
          allLessons: lessons,
          progressMap: progressMap,
        ),
        isTrue,
      );
    });

    test(
        'third lesson is locked if second not completed (even if first is)', () {
      final progressMap = _buildProgressMap(
        courseId: _courseId,
        lessonCompletions: {'l1': true, 'l2': false},
      );
      expect(
        unlockPolicy.isLessonUnlocked(
          lesson: lessons[2],
          allLessons: lessons,
          progressMap: progressMap,
        ),
        isFalse,
      );
    });

    test('fourth lesson unlocked when all previous are completed', () {
      final progressMap = _buildProgressMap(
        courseId: _courseId,
        lessonCompletions: {'l1': true, 'l2': true, 'l3': true},
      );
      expect(
        unlockPolicy.isLessonUnlocked(
          lesson: lessons[3],
          allLessons: lessons,
          progressMap: progressMap,
        ),
        isTrue,
      );
    });

    test('lesson is locked if no progress exists (fresh state)', () {
      expect(
        unlockPolicy.isLessonUnlocked(
          lesson: lessons[2],
          allLessons: lessons,
          progressMap: {},
        ),
        isFalse,
      );
    });
  });

  group('UnlockPolicy - findNextLesson', () {
    test('returns next lesson for a middle lesson', () {
      final next = unlockPolicy.findNextLesson(
        currentLessonId: 'l2',
        allLessons: lessons,
      );
      expect(next?.id, equals('l3'));
    });

    test('returns null for the last lesson', () {
      final next = unlockPolicy.findNextLesson(
        currentLessonId: 'l4',
        allLessons: lessons,
      );
      expect(next, isNull);
    });

    test('returns second lesson as next for first lesson', () {
      final next = unlockPolicy.findNextLesson(
        currentLessonId: 'l1',
        allLessons: lessons,
      );
      expect(next?.id, equals('l2'));
    });
  });

  group('UnlockPolicy - findResumeLesson', () {
    test('returns in-progress lesson with watched seconds > 0', () {
      final progressMap = _buildProgressMap(
        courseId: _courseId,
        lessonCompletions: {'l1': true, 'l2': false},
      );
      final resume = unlockPolicy.findResumeLesson(
        allLessons: lessons,
        progressMap: progressMap,
      );
      expect(resume?.id, equals('l2'));
    });

    test('returns null when all lessons are completed', () {
      final progressMap = _buildProgressMap(
        courseId: _courseId,
        lessonCompletions: {
          'l1': true,
          'l2': true,
          'l3': true,
          'l4': true,
        },
      );
      final resume = unlockPolicy.findResumeLesson(
        allLessons: lessons,
        progressMap: progressMap,
      );
      expect(resume, isNull);
    });

    test('returns null when no lessons have been started', () {
      final resume = unlockPolicy.findResumeLesson(
        allLessons: lessons,
        progressMap: {},
      );
      expect(resume, isNull);
    });
  });
}
