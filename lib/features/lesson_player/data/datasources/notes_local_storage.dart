import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_note_model.dart';

class NotesLocalStorage {
  static const _boxName = 'lesson_notes';

  static Future<void> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<String>(_boxName);
    }
  }

  Box<String> get _box => Hive.box<String>(_boxName);

  String _key(String courseId, String lessonId) =>
      'notes_${courseId}_$lessonId';

  List<LessonNoteModel> getNotes(String courseId, String lessonId) {
    try {
      if (!Hive.isBoxOpen(_boxName)) return [];
      final jsonString = _box.get(_key(courseId, lessonId));
      if (jsonString == null || jsonString.isEmpty) return [];

      final list = jsonDecode(jsonString) as List<dynamic>;
      return list
          .map((item) => LessonNoteModel.fromJson(item as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (_) {
      return [];
    }
  }

  Future<void> saveNote(LessonNoteModel note) async {
    try {
      await openBox();
      final current = getNotes(note.courseId, note.lessonId);
      current.removeWhere((n) => n.id == note.id);
      current.insert(0, note);

      final data = current.map((n) => n.toJson()).toList();
      await _box.put(_key(note.courseId, note.lessonId), jsonEncode(data));
    } catch (_) {}
  }

  Future<void> deleteNote(
    String courseId,
    String lessonId,
    String noteId,
  ) async {
    try {
      await openBox();
      final current = getNotes(courseId, lessonId);
      current.removeWhere((n) => n.id == noteId);

      final data = current.map((n) => n.toJson()).toList();
      await _box.put(_key(courseId, lessonId), jsonEncode(data));
    } catch (_) {}
  }
}
