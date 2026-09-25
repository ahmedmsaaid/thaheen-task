import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/core/utils/app_toast.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/notes_controller.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_add_note_card.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_note_item.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_resources_card.dart';

class LessonNotesResourcesTab extends ConsumerStatefulWidget {
  final String courseId;
  final String lessonId;
  final BetterPlayerService service;

  const LessonNotesResourcesTab({
    super.key,
    required this.courseId,
    required this.lessonId,
    required this.service,
  });

  @override
  ConsumerState<LessonNotesResourcesTab> createState() => _TabState();
}

class _TabState extends ConsumerState<LessonNotesResourcesTab> {
  final _controller = TextEditingController();

  void _addNote() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final pos = widget.service.currentPositionSec;
    final args = (courseId: widget.courseId, lessonId: widget.lessonId);
    ref.read(notesControllerProvider(args).notifier).addNote(text: text, timeSec: pos);
    _controller.clear();
    FocusScope.of(context).unfocus();
    AppToast.showSuccess(context, message: PlayerStrings.noteSavedSuccess);
  }

  void _deleteNote(String noteId) {
    final args = (courseId: widget.courseId, lessonId: widget.lessonId);
    ref.read(notesControllerProvider(args).notifier).deleteNote(noteId);
    AppToast.showSuccess(context, message: PlayerStrings.noteDeletedSuccess);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = (courseId: widget.courseId, lessonId: widget.lessonId);
    final notes = ref.watch(notesControllerProvider(args));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LessonAddNoteCard(controller: _controller, onAddNote: _addNote),
        SizedBox(height: 16.h),
        if (notes.isNotEmpty) ...[
          Text('${PlayerStrings.savedNotes} (${notes.length})', style: AppTextStyles.h3(context)),
          SizedBox(height: 8.h),
          for (final note in notes)
            LessonNoteItem(
              text: note.text,
              formattedTime: note.formattedTime,
              onSeek: () => widget.service.controller?.seekTo(Duration(seconds: note.timeSec)),
              onDelete: () => _deleteNote(note.id),
            ),
          SizedBox(height: 16.h),
        ] else ...[
          Text(AppStrings.noNotesYet, style: AppTextStyles.caption(context)),
          SizedBox(height: 16.h),
        ],
        const LessonResourcesCard(),
      ],
    );
  }
}


