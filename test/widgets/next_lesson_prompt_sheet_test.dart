import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/features/courses/data/models/lesson_model.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/next_lesson_prompt_data.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/next_lesson_prompt_sheet.dart';
import '../test_helper.dart';

void main() {
  const completedLesson = Lesson(
    id: 'l1',
    title: 'الدرس الأول المكتمل',
    durationSec: 120,
    videoPath: 'assets/videos/lesson1.mp4',
  );

  const nextLesson = Lesson(
    id: 'l2',
    title: 'الدرس الثاني التالي',
    durationSec: 240,
    videoPath: 'assets/videos/lesson2.mp4',
  );

  const promptData = NextLessonPromptData(
    courseId: 'c1',
    completedLesson: completedLesson,
    nextLesson: nextLesson,
  );

  testWidgets('NextLessonPromptSheet displays prompt titles and action buttons', (tester) async {
    bool dismissed = false;

    await tester.pumpWidget(
      createTestWidget(
        NextLessonPromptSheet(
          data: promptData,
          onDismiss: () => dismissed = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.nextLessonPromptTitle), findsOneWidget);
    expect(find.text(AppStrings.nextLessonPromptSubtitle), findsOneWidget);
    expect(find.text('الدرس الثاني التالي'), findsOneWidget);
    expect(find.text(AppStrings.playNextLessonButton), findsOneWidget);
    expect(find.text(AppStrings.playLaterButton), findsOneWidget);

    await tester.tap(find.text(AppStrings.playLaterButton));
    await tester.pumpAndSettle();
    expect(dismissed, isTrue);
  });
}
