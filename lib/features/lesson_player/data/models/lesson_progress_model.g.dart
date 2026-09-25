part of 'lesson_progress_model.dart';

class LessonProgressModelAdapter extends TypeAdapter<LessonProgressModel> {
  @override
  final int typeId = 0;

  @override
  LessonProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonProgressModel(
      lessonId: fields[0] as String,
      courseId: fields[1] as String,
      watchedSeconds: fields[2] as int,
      isCompleted: fields[3] as bool,
      lastWatched: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LessonProgressModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.lessonId)
      ..writeByte(1)
      ..write(obj.courseId)
      ..writeByte(2)
      ..write(obj.watchedSeconds)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.lastWatched);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
