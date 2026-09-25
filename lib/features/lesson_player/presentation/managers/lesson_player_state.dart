import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';

typedef LessonPlayerArgs = ({String courseId, String lessonId});

class PlayerDataInternal {
  final CourseModel course;
  final LessonModel currentLesson;
  final LessonModel? nextLesson;
  final int resumeFromSeconds;

  const PlayerDataInternal({
    required this.course,
    required this.currentLesson,
    this.nextLesson,
    required this.resumeFromSeconds,
  });
}

class LessonPlayerState {
  final AsyncValue<PlayerDataInternal> playerData;
  final bool isCompleted;
  final bool completionJustAchieved;

  const LessonPlayerState({
    required this.playerData,
    this.isCompleted = false,
    this.completionJustAchieved = false,
  });

  LessonPlayerState copyWith({
    AsyncValue<PlayerDataInternal>? playerData,
    bool? isCompleted,
    bool? completionJustAchieved,
  }) {
    return LessonPlayerState(
      playerData: playerData ?? this.playerData,
      isCompleted: isCompleted ?? this.isCompleted,
      completionJustAchieved:
          completionJustAchieved ?? this.completionJustAchieved,
    );
  }
}
