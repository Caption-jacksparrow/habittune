import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../models/habit_model.dart';

/// Implementation of the HabitRepository interface using Hive
class HabitRepositoryImpl implements HabitRepository {
  final Box<HabitModel> _habitsBox;

  HabitRepositoryImpl() : _habitsBox = Hive.box<HabitModel>(AppConstants.habitsBoxName);

  @override
  Future<List<Habit>> getHabits() async {
    return _habitsBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Habit?> getHabit(String id) async {
    final habitModel = _habitsBox.get(id);
    return habitModel?.toEntity();
  }

  @override
  Future<void> saveHabit(Habit habit) async {
    await _habitsBox.put(habit.id, HabitModel.fromEntity(habit));
  }

  @override
  Future<void> deleteHabit(String id) async {
    await _habitsBox.delete(id);
  }

  @override
  Future<void> archiveHabit(String id) async {
    final habit = await getHabit(id);
    if (habit != null) {
      final updatedHabit = habit.copyWith(isArchived: true);
      await saveHabit(updatedHabit);
    }
  }

  @override
  Future<List<Habit>> getHabitsForToday() async {
    final now = DateTime.now();
    final weekday = now.weekday; // 1-7 for Monday-Sunday
    
    return _habitsBox.values.where((habitModel) {
      // Skip archived habits
      if (habitModel.isArchived) return false;
      
      // Check frequency type
      switch (HabitFrequency.values[habitModel.frequencyIndex]) {
        case HabitFrequency.daily:
          return true;
        case HabitFrequency.specificDays:
          return habitModel.specificDays.contains(weekday);
        case HabitFrequency.xTimesPerWeek:
          // For x times per week, we'll need to check completions
          // This is a simplified implementation
          return true;
        default:
          return false;
      }
    }).map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Habit>> getHabitsByFrequency(HabitFrequency frequency) async {
    return _habitsBox.values
        .where((habitModel) => 
            HabitFrequency.values[habitModel.frequencyIndex] == frequency && 
            !habitModel.isArchived)
        .map((model) => model.toEntity())
        .toList();
  }
}
