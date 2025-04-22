import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:habittune/domain/repositories/habit_repository.dart';
import 'package:habittune/domain/usecases/get_habits_usecase.dart';
import 'package:habittune/domain/entities/habit.dart';

import 'get_habits_usecase_test.mocks.dart';

@GenerateMocks([HabitRepository])
void main() {
  late GetHabitsUseCase useCase;
  late MockHabitRepository mockHabitRepository;

  setUp(() {
    mockHabitRepository = MockHabitRepository();
    useCase = GetHabitsUseCase(mockHabitRepository);
  });

  final testHabits = [
    Habit(
      id: 'habit-1',
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
    ),
    Habit(
      id: 'habit-2',
      title: 'Evening Reading',
      description: 'Read before bed',
      frequency: HabitFrequency.daily,
      goalType: HabitGoalType.duration,
      specificDays: const [],
      timesPerWeek: 0,
      targetDuration: 20,
      targetQuantity: 0,
      reminderTime: '',
      colorTag: '#2196F3',
      icon: 'book',
      createdAt: DateTime(2025, 4, 22),
    ),
  ];

  test('should get all habits from the repository', () async {
    // Arrange
    when(mockHabitRepository.getHabits())
        .thenAnswer((_) async => testHabits);

    // Act
    final result = await useCase.execute();

    // Assert
    expect(result, testHabits);
    verify(mockHabitRepository.getHabits());
    verifyNoMoreInteractions(mockHabitRepository);
  });
}
