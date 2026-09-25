import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/features/lesson_player/data/datasources/notes_local_storage.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_note_model.dart';

final notesLocalStorageProvider = Provider<NotesLocalStorage>(
  (ref) => NotesLocalStorage(),
);

typedef LessonArgs = ({String courseId, String lessonId});

class NotesController extends FamilyNotifier<List<LessonNoteModel>, LessonArgs> {
  @override
  List<LessonNoteModel> build(LessonArgs arg) {
    final storage = ref.watch(notesLocalStorageProvider);
    return storage.getNotes(arg.courseId, arg.lessonId);
  }

  Future<void> addNote({required String text, required int timeSec}) async {
    if (text.trim().isEmpty) return;

    final m = timeSec ~/ 60;
    final s = timeSec % 60;
    final formattedTime =
        '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';

    final note = LessonNoteModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      courseId: arg.courseId,
      lessonId: arg.lessonId,
      text: text.trim(),
      timeSec: timeSec,
      formattedTime: formattedTime,
      createdAt: DateTime.now(),
    );

    state = [note, ...state];
    final storage = ref.read(notesLocalStorageProvider);
    await storage.saveNote(note);
  }

  Future<void> deleteNote(String noteId) async {
    state = state.where((n) => n.id != noteId).toList();
    final storage = ref.read(notesLocalStorageProvider);
    await storage.deleteNote(arg.courseId, arg.lessonId, noteId);
  }
}

final notesControllerProvider =
    NotifierProvider.family<NotesController, List<LessonNoteModel>, LessonArgs>(
  NotesController.new,
);
