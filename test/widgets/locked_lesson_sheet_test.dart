import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/features/course_details/presentation/screens/widgets/locked_lesson_sheet.dart';
import '../test_helper.dart';

void main() {
  testWidgets('LockedLessonSheet displays locked lesson details and closes on tap', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      createTestWidget(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => LockedLessonSheet.show(context, 'تشريح الجهاز العصبي'),
            child: const Text('Open Sheet'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Sheet'));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.lessonLockedTitle), findsOneWidget);
    expect(find.text('تشريح الجهاز العصبي'), findsOneWidget);
    expect(find.text(AppStrings.lessonLockedDescription), findsOneWidget);
    expect(find.text(AppStrings.ok), findsOneWidget);

    await tester.tap(find.text(AppStrings.ok));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.lessonLockedTitle), findsNothing);
  });
}
