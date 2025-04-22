import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

/// Use case for getting habits due for today
class GetTodayHabitsUseCase {
  final HabitRepository repository;

  GetTodayHabitsUseCase(this.repository);

  /// Execute the use case to get habits due for today
  Future<List<Habit>> execute() {
    return repository.getHabitsForToday();
  }
}
