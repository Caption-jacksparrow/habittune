import 'package:equatable/equatable.dart';

/// Represents a user achievement in the gamification system
class Achievement extends Equatable {
  final String id;
  final String title;
  final String description;
  final int pointsValue;
  final String iconName;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final String category;
  final int level; // Difficulty or progression level

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsValue,
    required this.iconName,
    this.isUnlocked = false,
    this.unlockedAt,
    required this.category,
    this.level = 1,
  });

  /// Create a copy of this Achievement with the given fields replaced with new values
  Achievement copyWith({
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
    return Achievement(
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

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        pointsValue,
        iconName,
        isUnlocked,
        unlockedAt,
        category,
        level,
      ];
}
