import 'package:flutter_test/flutter_test.dart';
import 'package:habittune/domain/entities/habit_completion.dart';
import 'package:habittune/domain/entities/habit.dart';

void main() {
  group('HabitCompletion Entity Tests', () {
    test('should create a valid HabitCompletion entity', () {
      // Arrange
      final completion = HabitCompletion(
        id: 'completion-id',
        habitId: 'habit-id',
        completedAt: DateTime(2025, 4, 22, 10, 30),
        durationMinutes: 15,
        quantity: 0,
        notes: 'Felt great today',
      );

      // Assert
      expect(completion.id, 'completion-id');
      expect(completion.habitId, 'habit-id');
      expect(completion.completedAt, DateTime(2025, 4, 22, 10, 30));
      expect(completion.durationMinutes, 15);
      expect(completion.quantity, 0);
      expect(completion.notes, 'Felt great today');
    });

    test('should create a copy with updated values', () {
      // Arrange
      final completion = HabitCompletion(
        id: 'completion-id',
        habitId: 'habit-id',
        completedAt: DateTime(2025, 4, 22, 10, 30),
        durationMinutes: 15,
        quantity: 0,
        notes: 'Felt great today',
      );

      // Act
      final updatedCompletion = completion.copyWith(
        durationMinutes: 20,
        notes: 'Extended the session',
      );

      // Assert
      expect(updatedCompletion.id, 'completion-id'); // Should remain the same
      expect(updatedCompletion.habitId, 'habit-id'); // Should remain the same
      expect(updatedCompletion.completedAt, DateTime(2025, 4, 22, 10, 30)); // Should remain the same
      expect(updatedCompletion.durationMinutes, 20); // Should be updated
      expect(updatedCompletion.quantity, 0); // Should remain the same
      expect(updatedCompletion.notes, 'Extended the session'); // Should be updated
    });

    test('should create appropriate completion based on habit goal type', () {
      // Arrange - Create habits with different goal types
      final yesNoHabit = Habit(
        id: 'yesno-habit',
        title: 'Yes/No Habit',
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
      
      final durationHabit = Habit(
        id: 'duration-habit',
        title: 'Duration Habit',
        description: '',
        frequency: HabitFrequency.daily,
        goalType: HabitGoalType.duration,
        specificDays: const [],
        timesPerWeek: 0,
        targetDuration: 15,
        targetQuantity: 0,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'check',
        createdAt: DateTime(2025, 4, 22),
      );
      
      final quantityHabit = Habit(
        id: 'quantity-habit',
        title: 'Quantity Habit',
        description: '',
        frequency: HabitFrequency.daily,
        goalType: HabitGoalType.quantity,
        specificDays: const [],
        timesPerWeek: 0,
        targetDuration: 0,
        targetQuantity: 5,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'check',
        createdAt: DateTime(2025, 4, 22),
      );

      // Act - Create completions for each habit type
      final yesNoCompletion = HabitCompletion(
        id: 'yesno-completion',
        habitId: yesNoHabit.id,
        completedAt: DateTime(2025, 4, 22, 10, 30),
        durationMinutes: 0,
        quantity: 0,
        notes: '',
      );
      
      final durationCompletion = HabitCompletion(
        id: 'duration-completion',
        habitId: durationHabit.id,
        completedAt: DateTime(2025, 4, 22, 10, 30),
        durationMinutes: durationHabit.targetDuration,
        quantity: 0,
        notes: '',
      );
      
      final quantityCompletion = HabitCompletion(
        id: 'quantity-completion',
        habitId: quantityHabit.id,
        completedAt: DateTime(2025, 4, 22, 10, 30),
        durationMinutes: 0,
        quantity: quantityHabit.targetQuantity,
        notes: '',
      );

      // Assert
      expect(yesNoCompletion.durationMinutes, 0);
      expect(yesNoCompletion.quantity, 0);
      
      expect(durationCompletion.durationMinutes, 15);
      expect(durationCompletion.quantity, 0);
      
      expect(quantityCompletion.durationMinutes, 0);
      expect(quantityCompletion.quantity, 5);
    });
  });
}
