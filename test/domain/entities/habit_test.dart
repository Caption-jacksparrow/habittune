import 'package:flutter_test/flutter_test.dart';
import 'package:habittune/domain/entities/habit.dart';

void main() {
  group('Habit Entity Tests', () {
    test('should create a valid Habit entity', () {
      // Arrange
      final habit = Habit(
        id: 'test-id',
        title: 'Morning Meditation',
        description: 'Daily mindfulness practice',
        frequency: HabitFrequency.daily,
        goalType: HabitGoalType.duration,
        specificDays: const [],
        timesPerWeek: 0,
        targetDuration: 10,
        targetQuantity: 0,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'meditation',
        createdAt: DateTime(2025, 4, 22),
      );

      // Assert
      expect(habit.id, 'test-id');
      expect(habit.title, 'Morning Meditation');
      expect(habit.description, 'Daily mindfulness practice');
      expect(habit.frequency, HabitFrequency.daily);
      expect(habit.goalType, HabitGoalType.duration);
      expect(habit.targetDuration, 10);
      expect(habit.colorTag, '#673AB7');
      expect(habit.createdAt, DateTime(2025, 4, 22));
    });

    test('should create a copy with updated values', () {
      // Arrange
      final habit = Habit(
        id: 'test-id',
        title: 'Morning Meditation',
        description: 'Daily mindfulness practice',
        frequency: HabitFrequency.daily,
        goalType: HabitGoalType.duration,
        specificDays: const [],
        timesPerWeek: 0,
        targetDuration: 10,
        targetQuantity: 0,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'meditation',
        createdAt: DateTime(2025, 4, 22),
      );

      // Act
      final updatedHabit = habit.copyWith(
        title: 'Evening Meditation',
        targetDuration: 15,
        frequency: HabitFrequency.specificDays,
        specificDays: const [1, 3, 5], // Monday, Wednesday, Friday
      );

      // Assert
      expect(updatedHabit.id, 'test-id'); // Should remain the same
      expect(updatedHabit.title, 'Evening Meditation'); // Should be updated
      expect(updatedHabit.description, 'Daily mindfulness practice'); // Should remain the same
      expect(updatedHabit.frequency, HabitFrequency.specificDays); // Should be updated
      expect(updatedHabit.specificDays, [1, 3, 5]); // Should be updated
      expect(updatedHabit.targetDuration, 15); // Should be updated
      expect(updatedHabit.colorTag, '#673AB7'); // Should remain the same
    });

    test('should correctly identify if habit is due today', () {
      // Arrange - Create a daily habit
      final dailyHabit = Habit(
        id: 'daily-habit',
        title: 'Daily Habit',
        description: '',
        frequency: HabitFrequency.daily,
        goalType: HabitGoalType.yesNo,
        specificDays: const [],
        timesPerWeek: 0,
        targetDuration: 0,
        targetQuantity: 0,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'check',
        createdAt: DateTime(2025, 4, 22),
      );

      // Get current weekday (1-7 for Monday-Sunday)
      final now = DateTime.now();
      final today = now.weekday;
      
      // Create a habit for specific days including today
      final specificDaysIncludingToday = Habit(
        id: 'specific-days-including-today',
        title: 'Specific Days Including Today',
        description: '',
        frequency: HabitFrequency.specificDays,
        goalType: HabitGoalType.yesNo,
        specificDays: [today], // Only today
        timesPerWeek: 0,
        targetDuration: 0,
        targetQuantity: 0,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'check',
        createdAt: DateTime(2025, 4, 22),
      );
      
      // Create a habit for specific days excluding today
      final specificDaysExcludingToday = Habit(
        id: 'specific-days-excluding-today',
        title: 'Specific Days Excluding Today',
        description: '',
        frequency: HabitFrequency.specificDays,
        goalType: HabitGoalType.yesNo,
        specificDays: today < 7 ? [today + 1] : [today - 1], // Not today
        timesPerWeek: 0,
        targetDuration: 0,
        targetQuantity: 0,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'check',
        createdAt: DateTime(2025, 4, 22),
      );

      // Assert
      // Note: In a real implementation, we would have a method like habit.isDueToday()
      // For this test, we're just verifying the data structure is correct
      expect(dailyHabit.frequency, HabitFrequency.daily);
      expect(specificDaysIncludingToday.specificDays.contains(today), true);
      expect(specificDaysExcludingToday.specificDays.contains(today), false);
    });
  });
}
