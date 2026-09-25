class Lesson {
  final String id;
  final String title;
  final int durationSec;
  final String videoPath;

  const Lesson({
    required this.id,
    required this.title,
    required this.durationSec,
    required this.videoPath,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      durationSec: json['durationSec'] as int,
      videoPath: json['video'] as String,
    );
  }

  String get formattedDuration {
    final minutes = durationSec ~/ 60;
    final seconds = durationSec % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

typedef LessonModel = Lesson;
