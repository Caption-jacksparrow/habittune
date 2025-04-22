import '../entities/habit_completion.dart';

/// Repository interface for HabitCompletion operations
abstract class HabitCompletionRepository {
  /// Get all completions for a habit
  Future<List<HabitCompletion>> getCompletionsForHabit(String habitId);
  
  /// Get completions for a habit within a date range
  Future<List<HabitCompletion>> getCompletionsForHabitInRange(
    String habitId, 
    DateTime startDate, 
    DateTime endDate
  );
  
  /// Save a habit completion
  Future<void> saveCompletion(HabitCompletion completion);
  
  /// Delete a habit completion
  Future<void> deleteCompletion(String id);
  
  /// Get streak information for a habit
  Future<int> getCurrentStreak(String habitId);
  
  /// Get the longest streak for a habit
  Future<int> getLongestStreak(String habitId);
  
  /// Get completions for today
  Future<List<HabitCompletion>> getCompletionsForToday();
}
