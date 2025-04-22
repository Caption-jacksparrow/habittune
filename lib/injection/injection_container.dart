import 'package:get_it/get_it.dart';
import '../core/utils/hive_init.dart';
import '../data/repositories/habit_repository_impl.dart';
import '../data/repositories/habit_completion_repository_impl.dart';
import '../data/repositories/achievement_repository_impl.dart';
import '../domain/repositories/habit_repository.dart';
import '../domain/repositories/habit_completion_repository.dart';
import '../domain/repositories/achievement_repository.dart';
import '../domain/usecases/get_habits_usecase.dart';
import '../domain/usecases/get_today_habits_usecase.dart';
import '../domain/usecases/save_habit_usecase.dart';
import '../domain/usecases/save_completion_usecase.dart';
import '../domain/usecases/get_completions_for_habit_usecase.dart';
import '../domain/usecases/get_streak_usecase.dart';
import '../domain/usecases/get_achievements_usecase.dart';
import '../domain/usecases/unlock_achievement_usecase.dart';
import '../presentation/bloc/habit_bloc.dart';
import '../presentation/bloc/completion_bloc.dart';
import '../presentation/bloc/achievement_bloc.dart';

final GetIt sl = GetIt.instance;

/// Initialize dependency injection
Future<void> initDependencies() async {
  // Initialize Hive
  await HiveInit.init();
  
  // Repositories
  sl.registerLazySingleton<HabitRepository>(() => HabitRepositoryImpl());
  sl.registerLazySingleton<HabitCompletionRepository>(() => HabitCompletionRepositoryImpl());
  sl.registerLazySingleton<AchievementRepository>(() => AchievementRepositoryImpl());
  
  // Use cases
  sl.registerLazySingleton(() => GetHabitsUseCase(sl()));
  sl.registerLazySingleton(() => GetTodayHabitsUseCase(sl()));
  sl.registerLazySingleton(() => SaveHabitUseCase(sl()));
  sl.registerLazySingleton(() => SaveCompletionUseCase(sl()));
  sl.registerLazySingleton(() => GetCompletionsForHabitUseCase(sl()));
  sl.registerLazySingleton(() => GetStreakUseCase(sl()));
  sl.registerLazySingleton(() => GetAchievementsUseCase(sl()));
  sl.registerLazySingleton(() => UnlockAchievementUseCase(sl()));
  
  // BLoC
  sl.registerFactory(() => HabitBloc(habitRepository: sl()));
  sl.registerFactory(() => CompletionBloc(completionRepository: sl()));
  sl.registerFactory(() => AchievementBloc(achievementRepository: sl()));
}
