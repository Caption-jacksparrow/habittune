import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

/// Use case for saving a habit
class SaveHabitUseCase {
  final HabitRepository repository;

  SaveHabitUseCase(this.repository);

  /// Execute the use case to save a habit
  Future<void> execute(Habit habit) {
    return repository.saveHabit(habit);
  }
}
