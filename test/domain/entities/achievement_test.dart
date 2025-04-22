import 'package:flutter_test/flutter_test.dart';
import 'package:habittune/domain/entities/achievement.dart';

void main() {
  group('Achievement Entity Tests', () {
    test('should create a valid Achievement entity', () {
      // Arrange
      final achievement = Achievement(
        id: 'achievement-id',
        title: 'Early Bird',
        description: 'Complete a habit before 8 AM for 5 consecutive days',
        category: 'consistency',
        icon: 'star',
        isUnlocked: false,
        unlockedAt: null,
        createdAt: DateTime(2025, 4, 22),
      );

      // Assert
      expect(achievement.id, 'achievement-id');
      expect(achievement.title, 'Early Bird');
      expect(achievement.description, 'Complete a habit before 8 AM for 5 consecutive days');
      expect(achievement.category, 'consistency');
      expect(achievement.icon, 'star');
      expect(achievement.isUnlocked, false);
      expect(achievement.unlockedAt, null);
      expect(achievement.createdAt, DateTime(2025, 4, 22));
    });

    test('should create a copy with updated values', () {
      // Arrange
      final achievement = Achievement(
        id: 'achievement-id',
        title: 'Early Bird',
        description: 'Complete a habit before 8 AM for 5 consecutive days',
        category: 'consistency',
        icon: 'star',
        isUnlocked: false,
        unlockedAt: null,
        createdAt: DateTime(2025, 4, 22),
      );

      // Act - Unlock the achievement
      final unlockTime = DateTime(2025, 4, 25, 7, 30);
      final unlockedAchievement = achievement.copyWith(
        isUnlocked: true,
        unlockedAt: unlockTime,
      );

      // Assert
      expect(unlockedAchievement.id, 'achievement-id'); // Should remain the same
      expect(unlockedAchievement.title, 'Early Bird'); // Should remain the same
      expect(unlockedAchievement.isUnlocked, true); // Should be updated
      expect(unlockedAchievement.unlockedAt, unlockTime); // Should be updated
    });

    test('should handle different achievement categories', () {
      // Arrange - Create achievements with different categories
      final consistencyAchievement = Achievement(
        id: 'consistency-achievement',
        title: 'Consistency Master',
        description: 'Complete the same habit for 30 consecutive days',
        category: 'consistency',
        icon: 'trophy',
        isUnlocked: false,
        unlockedAt: null,
        createdAt: DateTime(2025, 4, 22),
      );
      
      final milestoneAchievement = Achievement(
        id: 'milestone-achievement',
        title: 'Century Club',
        description: 'Complete a total of 100 habits',
        category: 'milestone',
        icon: 'medal',
        isUnlocked: false,
        unlockedAt: null,
        createdAt: DateTime(2025, 4, 22),
      );
      
      final challengeAchievement = Achievement(
        id: 'challenge-achievement',
        title: 'Early Riser',
        description: 'Complete a morning habit for a week',
        category: 'challenge',
        icon: 'fire',
        isUnlocked: false,
        unlockedAt: null,
        createdAt: DateTime(2025, 4, 22),
      );

      // Assert
      expect(consistencyAchievement.category, 'consistency');
      expect(milestoneAchievement.category, 'milestone');
      expect(challengeAchievement.category, 'challenge');
    });
  });
}
