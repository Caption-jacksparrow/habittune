import '../entities/achievement.dart';

/// Repository interface for Achievement operations
abstract class AchievementRepository {
  /// Get all achievements
  Future<List<Achievement>> getAchievements();
  
  /// Get unlocked achievements
  Future<List<Achievement>> getUnlockedAchievements();
  
  /// Get locked achievements
  Future<List<Achievement>> getLockedAchievements();
  
  /// Get achievement by ID
  Future<Achievement?> getAchievement(String id);
  
  /// Save an achievement
  Future<void> saveAchievement(Achievement achievement);
  
  /// Unlock an achievement
  Future<void> unlockAchievement(String id);
  
  /// Get achievements by category
  Future<List<Achievement>> getAchievementsByCategory(String category);
}
