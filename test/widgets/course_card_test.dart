import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/features/courses/data/models/course_model.dart';
import 'package:thaheen/features/courses/presentation/managers/courses_state.dart';
import 'package:thaheen/features/courses/presentation/screens/widgets/course_list_item.dart';
import '../test_helper.dart';

void main() {
  const dummyCourse = Course(
    id: 'c1',
    title: 'علم التشريح العام',
    instructor: 'د. أحمد سعيد',
    thumbnail: 'assets/images/anatomy.jpg',
    sections: [
      Section(
        id: 's1',
        title: 'الوحدة الأولى',
        lessons: [
          Lesson(
            id: 'l1',
            title: 'مقدمة في علم التشريح',
            durationSec: 300,
            videoPath: 'assets/videos/lesson1.mp4',
          ),
        ],
      ),
    ],
  );

  testWidgets('CourseListItem renders course info and responds to tap', (tester) async {
    bool tapped = false;
    const vm = CourseViewModel(
      course: dummyCourse,
      completedLessons: 1,
      progressRatio: 1.0,
      hasStarted: true,
    );

    await tester.pumpWidget(
      createTestWidget(
        CourseListItem(
          viewModel: vm,
          onTap: () => tapped = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('علم التشريح العام'), findsOneWidget);
    expect(find.text('د. أحمد سعيد'), findsOneWidget);
    expect(find.text('1 ${AppStrings.lessonsCount}'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);

    await tester.tap(find.byType(CourseListItem));
    expect(tapped, isTrue);
  });
}
