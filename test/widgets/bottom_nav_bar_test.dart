import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/hat_nav_item_widget.dart';
import 'package:thaheen/features/main_layout/presentation/screens/widgets/main_bottom_nav_bar.dart';
import '../test_helper.dart';

void main() {
  testWidgets('MainBottomNavBar renders 3 items and notifies on tap', (tester) async {
    int selectedTab = 0;

    await tester.pumpWidget(
      createTestWidget(
        MainBottomNavBar(
          currentIndex: selectedTab,
          onTabSelected: (index) => selectedTab = index,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.navCourses), findsOneWidget);
    expect(find.byType(HatNavItemWidget), findsNWidgets(3));

    await tester.tap(find.byType(HatNavItemWidget).at(1));
    expect(selectedTab, equals(1));

    await tester.tap(find.byType(HatNavItemWidget).at(2));
    expect(selectedTab, equals(2));
  });
}
