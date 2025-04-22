import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:habittune/domain/repositories/habit_completion_repository.dart';
import 'package:habittune/domain/usecases/get_streak_usecase.dart';

import 'get_streak_usecase_test.mocks.dart';

@GenerateMocks([HabitCompletionRepository])
void main() {
  late GetStreakUseCase useCase;
  late MockHabitCompletionRepository mockRepository;

  setUp(() {
    mockRepository = MockHabitCompletionRepository();
    useCase = GetStreakUseCase(mockRepository);
  });

  const testHabitId = 'test-habit-id';
  const currentStreak = 5;
  const longestStreak = 10;

  test('should get current streak from the repository', () async {
    // Arrange
    when(mockRepository.getCurrentStreak(testHabitId))
        .thenAnswer((_) async => currentStreak);

    // Act
    final result = await useCase.getCurrentStreak(testHabitId);

    // Assert
    expect(result, currentStreak);
    verify(mockRepository.getCurrentStreak(testHabitId));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should get longest streak from the repository', () async {
    // Arrange
    when(mockRepository.getLongestStreak(testHabitId))
        .thenAnswer((_) async => longestStreak);

    // Act
    final result = await useCase.getLongestStreak(testHabitId);

    // Assert
    expect(result, longestStreak);
    verify(mockRepository.getLongestStreak(testHabitId));
    verifyNoMoreInteractions(mockRepository);
  });
}
