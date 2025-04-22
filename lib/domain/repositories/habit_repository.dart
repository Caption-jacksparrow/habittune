import '../entities/habit.dart';

/// Repository interface for Habit operations
abstract class HabitRepository {
  /// Get all habits
  Future<List<Habit>> getHabits();
  
  /// Get a habit by ID
  Future<Habit?> getHabit(String id);
  
  /// Save a habit
  Future<void> saveHabit(Habit habit);
  
  /// Delete a habit
  Future<void> deleteHabit(String id);
  
  /// Archive a habit
  Future<void> archiveHabit(String id);
  
  /// Get habits due for today
  Future<List<Habit>> getHabitsForToday();
  
  /// Get habits by frequency type
  Future<List<Habit>> getHabitsByFrequency(HabitFrequency frequency);
}
