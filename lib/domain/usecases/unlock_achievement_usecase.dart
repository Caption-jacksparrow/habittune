import '../entities/achievement.dart';
import '../repositories/achievement_repository.dart';

/// Use case for unlocking an achievement
class UnlockAchievementUseCase {
  final AchievementRepository repository;

  UnlockAchievementUseCase(this.repository);

  /// Execute the use case to unlock an achievement
  Future<void> execute(String achievementId) {
    return repository.unlockAchievement(achievementId);
  }
}
