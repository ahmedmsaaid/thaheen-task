import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';
import 'package:thaheen/core/utils/app_toast.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_add_note_card.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_note_item.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/lesson_resources_card.dart';

class LessonNotesResourcesTab extends StatefulWidget {
  final BetterPlayerService service;

  const LessonNotesResourcesTab({
    super.key,
    required this.service,
  });

  @override
  State<LessonNotesResourcesTab> createState() =>
      _LessonNotesResourcesTabState();
}

class _LessonNotesResourcesTabState extends State<LessonNotesResourcesTab> {
  final _controller = TextEditingController();
  final List<({String text, int timeSec, String formattedTime})> _notes = [];

  String _formatTime(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _addNote() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final currentPos = widget.service.currentPositionSec;
    setState(() {
      _notes.insert(0, (
        text: text,
        timeSec: currentPos,
        formattedTime: _formatTime(currentPos),
      ));
      _controller.clear();
    });
    FocusScope.of(context).unfocus();
    AppToast.showSuccess(context, message: PlayerStrings.noteSavedSuccess);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LessonAddNoteCard(
          controller: _controller,
          onAddNote: _addNote,
        ),
        SizedBox(height: 16.h),
        if (_notes.isNotEmpty) ...[
          Text(
            '${PlayerStrings.savedNotes} (${_notes.length})',
            style: AppTextStyles.h3(context),
          ),
          SizedBox(height: 8.h),
          for (final note in _notes)
            LessonNoteItem(
              text: note.text,
              formattedTime: note.formattedTime,
              onSeek: () => widget.service.controller
                  ?.seekTo(Duration(seconds: note.timeSec)),
            ),
          SizedBox(height: 16.h),
        ],
        const LessonResourcesCard(),
      ],
    );
  }
}
