import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

/// Use case for getting streak information for a habit
class GetStreakUseCase {
  final HabitCompletionRepository repository;

  GetStreakUseCase(this.repository);

  /// Execute the use case to get current streak for a habit
  Future<int> getCurrentStreak(String habitId) {
    return repository.getCurrentStreak(habitId);
  }
  
  /// Execute the use case to get longest streak for a habit
  Future<int> getLongestStreak(String habitId) {
    return repository.getLongestStreak(habitId);
  }
}
