import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/theme_toggle_button.dart';
import 'package:thaheen/core/theme/theme_controller.dart';
import '../test_helper.dart';

class _FakeThemeController extends ThemeController {
  @override
  ThemeMode build() => ThemeMode.light;

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
  }
}

void main() {
  testWidgets('ThemeToggleButton toggles theme on tap', (tester) async {
    await tester.pumpWidget(
      createTestWidget(
        const ThemeToggleButton(),
        overrides: [
          themeControllerProvider.overrideWith(_FakeThemeController.new),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ThemeToggleButton), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    final element = tester.element(find.byType(ThemeToggleButton));
    final container = ProviderScope.containerOf(element);
    expect(container.read(themeControllerProvider), equals(ThemeMode.dark));
  });
}
