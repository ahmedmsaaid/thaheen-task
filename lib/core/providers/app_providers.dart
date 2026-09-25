import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thaheen/core/theme/theme_local_storage.dart';
import 'package:thaheen/features/course_details/data/repositories/course_details_repository.dart';
import 'package:thaheen/features/courses/data/datasources/local_courses_datasource.dart';
import 'package:thaheen/features/courses/data/repositories/courses_repository.dart';
import 'package:thaheen/features/lesson_player/data/datasources/progress_local_storage.dart';
import 'package:thaheen/features/lesson_player/data/repositories/progress_repository.dart';
import 'package:thaheen/features/lesson_player/domain/progress_calculator.dart';
import 'package:thaheen/features/lesson_player/domain/unlock_policy.dart';
import 'package:thaheen/features/lesson_player/presentation/managers/better_player_service.dart';

final betterPlayerServiceProvider =
    ChangeNotifierProvider<BetterPlayerService>((ref) {
  return BetterPlayerService(ref);
});

final localCoursesDataSourceProvider = Provider<LocalCoursesDataSource>(
  (ref) => const LocalCoursesDataSource(),
);

final progressLocalStorageProvider = Provider<ProgressLocalStorage>(
  (ref) => ProgressLocalStorage(),
);

final coursesRepositoryProvider = Provider<CoursesRepository>(
  (ref) => CoursesRepository(ref.read(localCoursesDataSourceProvider)),
);

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => ProgressRepository(ref.read(progressLocalStorageProvider)),
);

final progressCalculatorProvider = Provider<ProgressCalculator>(
  (ref) => const ProgressCalculator(),
);

final unlockPolicyProvider = Provider<UnlockPolicy>(
  (ref) => const UnlockPolicy(),
);

final courseDetailsRepositoryProvider = Provider<CourseDetailsRepository>(
  (ref) => CourseDetailsRepository(
    ref.read(coursesRepositoryProvider),
    ref.read(unlockPolicyProvider),
  ),
);

final playbackSpeedProvider = StateProvider<double>((ref) => 1.0);

final themeLocalStorageProvider =
    Provider<ThemeLocalStorage>((ref) => ThemeLocalStorage());
