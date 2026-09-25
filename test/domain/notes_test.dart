import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thaheen/features/lesson_player/data/datasources/notes_local_storage.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_note_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotesLocalStorage Tests', () {
    late NotesLocalStorage storage;
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('hive_notes_test');
      Hive.init(tempDir.path);
      await NotesLocalStorage.openBox();
      storage = NotesLocalStorage();
    });

    tearDown(() async {
      await Hive.close();
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('saves and retrieves lesson notes', () async {
      final note = LessonNoteModel(
        id: '1',
        courseId: 'c1',
        lessonId: 'l1',
        text: 'Important concept on enzymes',
        timeSec: 125,
        formattedTime: '02:05',
        createdAt: DateTime.now(),
      );

      await storage.saveNote(note);
      final notes = storage.getNotes('c1', 'l1');

      expect(notes.length, 1);
      expect(notes.first.text, 'Important concept on enzymes');
      expect(notes.first.formattedTime, '02:05');
    });

    test('deletes a note by id', () async {
      final note1 = LessonNoteModel(
        id: '1',
        courseId: 'c1',
        lessonId: 'l1',
        text: 'Note 1',
        timeSec: 30,
        formattedTime: '00:30',
        createdAt: DateTime.now(),
      );
      final note2 = LessonNoteModel(
        id: '2',
        courseId: 'c1',
        lessonId: 'l1',
        text: 'Note 2',
        timeSec: 60,
        formattedTime: '01:00',
        createdAt: DateTime.now().add(const Duration(seconds: 1)),
      );

      await storage.saveNote(note1);
      await storage.saveNote(note2);

      var notes = storage.getNotes('c1', 'l1');
      expect(notes.length, 2);

      await storage.deleteNote('c1', 'l1', '1');
      notes = storage.getNotes('c1', 'l1');

      expect(notes.length, 1);
      expect(notes.first.id, '2');
    });
  });
}
