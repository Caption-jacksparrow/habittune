import '../entities/achievement.dart';
import '../repositories/achievement_repository.dart';

/// Use case for getting achievements
class GetAchievementsUseCase {
  final AchievementRepository repository;

  GetAchievementsUseCase(this.repository);

  /// Execute the use case to get all achievements
  Future<List<Achievement>> execute() {
    return repository.getAchievements();
  }
  
  /// Get unlocked achievements
  Future<List<Achievement>> getUnlocked() {
    return repository.getUnlockedAchievements();
  }
  
  /// Get locked achievements
  Future<List<Achievement>> getLocked() {
    return repository.getLockedAchievements();
  }
  
  /// Get achievements by category
  Future<List<Achievement>> getByCategory(String category) {
    return repository.getAchievementsByCategory(category);
  }
}
