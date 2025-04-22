import '../entities/habit_completion.dart';
import '../repositories/habit_completion_repository.dart';

/// Use case for saving a habit completion
class SaveCompletionUseCase {
  final HabitCompletionRepository repository;

  SaveCompletionUseCase(this.repository);

  /// Execute the use case to save a habit completion
  Future<void> execute(HabitCompletion completion) {
    return repository.saveCompletion(completion);
  }
}
