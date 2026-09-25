class LessonNoteModel {
  final String id;
  final String courseId;
  final String lessonId;
  final String text;
  final int timeSec;
  final String formattedTime;
  final DateTime createdAt;

  const LessonNoteModel({
    required this.id,
    required this.courseId,
    required this.lessonId,
    required this.text,
    required this.timeSec,
    required this.formattedTime,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseId': courseId,
        'lessonId': lessonId,
        'text': text,
        'timeSec': timeSec,
        'formattedTime': formattedTime,
        'createdAt': createdAt.toIso8601String(),
      };

  factory LessonNoteModel.fromJson(Map<String, dynamic> json) =>
      LessonNoteModel(
        id: json['id'] as String,
        courseId: json['courseId'] as String,
        lessonId: json['lessonId'] as String,
        text: json['text'] as String,
        timeSec: (json['timeSec'] as num).toInt(),
        formattedTime: json['formattedTime'] as String,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );
}
