import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:habittune/domain/repositories/achievement_repository.dart';
import 'package:habittune/domain/usecases/unlock_achievement_usecase.dart';

import 'unlock_achievement_usecase_test.mocks.dart';

@GenerateMocks([AchievementRepository])
void main() {
  late UnlockAchievementUseCase useCase;
  late MockAchievementRepository mockRepository;

  setUp(() {
    mockRepository = MockAchievementRepository();
    useCase = UnlockAchievementUseCase(mockRepository);
  });

  const testAchievementId = 'test-achievement-id';

  test('should call unlockAchievement on the repository', () async {
    // Arrange
    when(mockRepository.unlockAchievement(testAchievementId))
        .thenAnswer((_) async => {});

    // Act
    await useCase.execute(testAchievementId);

    // Assert
    verify(mockRepository.unlockAchievement(testAchievementId));
    verifyNoMoreInteractions(mockRepository);
  });
}
