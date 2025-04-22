import 'package:hive/hive.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/repositories/achievement_repository.dart';
import '../models/achievement_model.dart';

/// Implementation of the AchievementRepository interface using Hive
class AchievementRepositoryImpl implements AchievementRepository {
  final Box<AchievementModel> _achievementsBox;

  AchievementRepositoryImpl() 
      : _achievementsBox = Hive.box<AchievementModel>(AppConstants.achievementsBoxName);

  @override
  Future<List<Achievement>> getAchievements() async {
    return _achievementsBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Achievement>> getUnlockedAchievements() async {
    return _achievementsBox.values
        .where((achievement) => achievement.isUnlocked)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<Achievement>> getLockedAchievements() async {
    return _achievementsBox.values
        .where((achievement) => !achievement.isUnlocked)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<Achievement?> getAchievement(String id) async {
    final achievementModel = _achievementsBox.get(id);
    return achievementModel?.toEntity();
  }

  @override
  Future<void> saveAchievement(Achievement achievement) async {
    await _achievementsBox.put(
        achievement.id, AchievementModel.fromEntity(achievement));
  }

  @override
  Future<void> unlockAchievement(String id) async {
    final achievement = await getAchievement(id);
    if (achievement != null && !achievement.isUnlocked) {
      final updatedAchievement = achievement.copyWith(
        isUnlocked: true,
        unlockedAt: DateTime.now(),
      );
      await saveAchievement(updatedAchievement);
    }
  }

  @override
  Future<List<Achievement>> getAchievementsByCategory(String category) async {
    return _achievementsBox.values
        .where((achievement) => achievement.category == category)
        .map((model) => model.toEntity())
        .toList();
  }
}
