import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/habit_completion.dart';
import '../../domain/repositories/habit_completion_repository.dart';
import '../models/habit_completion_model.dart';

/// Implementation of the HabitCompletionRepository interface using Hive
class HabitCompletionRepositoryImpl implements HabitCompletionRepository {
  final Box<HabitCompletionModel> _completionsBox;

  HabitCompletionRepositoryImpl() 
      : _completionsBox = Hive.box<HabitCompletionModel>(AppConstants.completionsBoxName);

  @override
  Future<List<HabitCompletion>> getCompletionsForHabit(String habitId) async {
    return _completionsBox.values
        .where((completion) => completion.habitId == habitId)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<HabitCompletion>> getCompletionsForHabitInRange(
      String habitId, DateTime startDate, DateTime endDate) async {
    return _completionsBox.values
        .where((completion) => 
            completion.habitId == habitId &&
            completion.completedAt.isAfter(startDate) &&
            completion.completedAt.isBefore(endDate.add(const Duration(days: 1))))
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<void> saveCompletion(HabitCompletion completion) async {
    await _completionsBox.put(
        completion.id, HabitCompletionModel.fromEntity(completion));
  }

  @override
  Future<void> deleteCompletion(String id) async {
    await _completionsBox.delete(id);
  }

  @override
  Future<int> getCurrentStreak(String habitId) async {
    // Get all completions for this habit
    final completions = await getCompletionsForHabit(habitId);
    if (completions.isEmpty) return 0;

    // Sort by date, most recent first
    completions.sort((a, b) => b.completedAt.compareTo(a.completedAt));

    // Calculate streak
    int streak = 1;
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    
    // Check if there's a completion today or yesterday to start the streak
    bool hasRecentCompletion = completions.any((completion) {
      final completionDate = DateTime(
        completion.completedAt.year,
        completion.completedAt.month,
        completion.completedAt.day,
      );
      return completionDate.isAtSameMomentAs(DateTime(today.year, today.month, today.day)) ||
             completionDate.isAtSameMomentAs(yesterday);
    });

    if (!hasRecentCompletion) return 0;

    // Calculate streak by checking consecutive days
    for (int i = 1; i < 1000; i++) { // Arbitrary limit to prevent infinite loop
      final checkDate = DateTime(today.year, today.month, today.day - i);
      final nextDate = DateTime(today.year, today.month, today.day - i - 1);
      
      bool hasCompletionOnCheckDate = completions.any((completion) {
        final completionDate = DateTime(
          completion.completedAt.year,
          completion.completedAt.month,
          completion.completedAt.day,
        );
        return completionDate.isAtSameMomentAs(checkDate);
      });
      
      if (hasCompletionOnCheckDate) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Future<int> getLongestStreak(String habitId) async {
    // Get all completions for this habit
    final completions = await getCompletionsForHabit(habitId);
    if (completions.isEmpty) return 0;

    // Sort by date
    completions.sort((a, b) => a.completedAt.compareTo(b.completedAt));

    // Group completions by day
    final Map<String, bool> completionsByDay = {};
    for (var completion in completions) {
      final date = DateTime(
        completion.completedAt.year,
        completion.completedAt.month,
        completion.completedAt.day,
      );
      completionsByDay[date.toString()] = true;
    }

    // Calculate longest streak
    int currentStreak = 0;
    int longestStreak = 0;
    
    // Get the date range to check
    final firstDate = DateTime(
      completions.first.completedAt.year,
      completions.first.completedAt.month,
      completions.first.completedAt.day,
    );
    final lastDate = DateTime(
      completions.last.completedAt.year,
      completions.last.completedAt.month,
      completions.last.completedAt.day,
    );

    // Check each day in the range
    for (var date = firstDate;
        date.isBefore(lastDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      if (completionsByDay.containsKey(date.toString())) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else {
        currentStreak = 0;
      }
    }

    return longestStreak;
  }

  @override
  Future<List<HabitCompletion>> getCompletionsForToday() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    
    return _completionsBox.values
        .where((completion) => 
            completion.completedAt.isAfter(today) &&
            completion.completedAt.isBefore(tomorrow))
        .map((model) => model.toEntity())
        .toList();
  }
}
