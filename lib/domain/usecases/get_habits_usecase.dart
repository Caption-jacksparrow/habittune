import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

/// Use case for getting all habits
class GetHabitsUseCase {
  final HabitRepository repository;

  GetHabitsUseCase(this.repository);

  /// Execute the use case to get all habits
  Future<List<Habit>> execute() {
    return repository.getHabits();
  }
}
