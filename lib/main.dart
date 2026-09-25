import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thaheen/core/constants/app_strings.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/theme/app_theme.dart';
import 'package:thaheen/core/theme/theme_controller.dart';
import 'package:thaheen/core/theme/theme_local_storage.dart';
import 'package:thaheen/features/lesson_player/data/datasources/progress_local_storage.dart';
import 'package:thaheen/features/lesson_player/data/models/lesson_progress_model.dart';

import 'package:thaheen/core/utils/app_toast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(LessonProgressModelAdapter());
  await ProgressLocalStorage.openBox();
  await ThemeLocalStorage.openBox();

  runApp(const ProviderScope(child: ThaheenApp()));
}

class ThaheenApp extends ConsumerWidget {
  const ThaheenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: AppStrings.appName,
        scaffoldMessengerKey: AppToast.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        routerConfig: AppRouter.router,
        builder: (context, routerChild) => Directionality(
          textDirection: TextDirection.rtl,
          child: routerChild!,
        ),
      ),
    );
  }
}
