import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

/// Use case for getting completions for a habit
class GetCompletionsForHabitUseCase {
  final HabitCompletionRepository repository;

  GetCompletionsForHabitUseCase(this.repository);

  /// Execute the use case to get completions for a habit
  Future<List<HabitCompletion>> execute(String habitId) {
    return repository.getCompletionsForHabit(habitId);
  }
}
