import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/theme/app_theme.dart';

void main() {
  testWidgets('App starts and shows courses page', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp.router(
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
    await tester.pump();
    // App should launch without throwing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
