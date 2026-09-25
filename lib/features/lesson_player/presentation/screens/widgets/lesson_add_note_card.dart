import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:thaheen/core/constants/player_strings.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class LessonAddNoteCard extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAddNote;

  const LessonAddNoteCard({
    super.key,
    required this.controller,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit_note_rounded, color: colors.primary, size: 22),
              SizedBox(width: 8.w),
              Text(PlayerStrings.addNote, style: AppTextStyles.h3(context)),
            ],
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: controller,
            style: AppTextStyles.bodyPrimary(context),
            maxLines: 2,
            decoration: InputDecoration(
              hintText: PlayerStrings.noteHint,
              hintStyle: AppTextStyles.caption(context),
              filled: true,
              fillColor: colors.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.all(12.r),
            ),
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              onPressed: onAddNote,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
              icon: const Icon(Icons.bookmark_add_rounded, size: 18),
              label:  Text(
                PlayerStrings.saveNote,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
