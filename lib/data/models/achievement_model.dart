import 'package:hive/hive.dart';
import '../../domain/entities/achievement.dart';

part 'achievement_model.g.dart';

/// Model class for Achievement with Hive support
@HiveType(typeId: 2)
class AchievementModel extends Achievement {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final int pointsValue;
  
  @HiveField(4)
  final String iconName;
  
  @HiveField(5)
  final bool isUnlocked;
  
  @HiveField(6)
  final DateTime? unlockedAt;
  
  @HiveField(7)
  final String category;
  
  @HiveField(8)
  final int level;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsValue,
    required this.iconName,
    this.isUnlocked = false,
    this.unlockedAt,
    required this.category,
    this.level = 1,
  }) : super(
          id: id,
          title: title,
          description: description,
          pointsValue: pointsValue,
          iconName: iconName,
          isUnlocked: isUnlocked,
          unlockedAt: unlockedAt,
          category: category,
          level: level,
        );

  /// Create an AchievementModel from an Achievement entity
  factory AchievementModel.fromEntity(Achievement achievement) {
    return AchievementModel(
      id: achievement.id,
      title: achievement.title,
      description: achievement.description,
      pointsValue: achievement.pointsValue,
      iconName: achievement.iconName,
      isUnlocked: achievement.isUnlocked,
      unlockedAt: achievement.unlockedAt,
      category: achievement.category,
      level: achievement.level,
    );
  }

  /// Convert this AchievementModel to an Achievement entity
  Achievement toEntity() {
    return Achievement(
      id: id,
      title: title,
      description: description,
      pointsValue: pointsValue,
      iconName: iconName,
      isUnlocked: isUnlocked,
      unlockedAt: unlockedAt,
      category: category,
      level: level,
    );
  }

  /// Create a copy of this AchievementModel with the given fields replaced with new values
  AchievementModel copyWith({
    String? id,
    String? title,
    String? description,
    int? pointsValue,
    String? iconName,
    bool? isUnlocked,
    DateTime? unlockedAt,
    String? category,
    int? level,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      pointsValue: pointsValue ?? this.pointsValue,
      iconName: iconName ?? this.iconName,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      category: category ?? this.category,
      level: level ?? this.level,
    );
  }
}
