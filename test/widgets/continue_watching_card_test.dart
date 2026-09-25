import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/continue_watching_card.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';
import '../test_helper.dart';

void main() {
  const dummyCourse = Course(
    id: 'c1',
    title: 'علم الأدوية',
    instructor: 'د. مروان',
    thumbnail: 'assets/images/pharmacology.jpg',
    sections: [
      Section(
        id: 's1',
        title: 'الوحدة 1',
        lessons: [
          Lesson(
            id: 'l1',
            title: 'المضادات الحيوية',
            durationSec: 600,
            videoPath: 'assets/videos/lesson1.mp4',
          ),
        ],
      ),
    ],
  );

  testWidgets('ContinueWatchingCard renders lesson info and responds to tap', (tester) async {
    bool tapped = false;
    final vm = ContinueWatchingViewModel(
      course: dummyCourse,
      lesson: dummyCourse.allLessons.first,
      progress: LessonProgressModel(
        courseId: 'c1',
        lessonId: 'l1',
        watchedSeconds: 300,
        isCompleted: false,
        lastWatched: DateTime.now(),
      ),
    );

    await tester.pumpWidget(
      createTestWidget(
        ContinueWatchingCard(
          viewModel: vm,
          onTap: () => tapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.continueWatching), findsOneWidget);
    expect(find.text('المضادات الحيوية'), findsOneWidget);
    expect(find.text('10:00 • 50% ${AppStrings.progress}'), findsOneWidget);

    await tester.tap(find.byType(ContinueWatchingCard));
    expect(tapped, isTrue);
  });
}
