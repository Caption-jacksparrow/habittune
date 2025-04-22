import 'package:equatable/equatable.dart';

/// Frequency options for habits
enum HabitFrequency {
  daily,
  specificDays,
  xTimesPerWeek,
}

/// Types of habit goals
enum HabitGoalType {
  yesNo,
  duration,
  quantity,
}

/// Entity representing a habit
class Habit extends Equatable {
  final String id;
  final String title;
  final String description;
  final HabitFrequency frequency;
  final HabitGoalType goalType;
  final List<int> specificDays; // 1-7 representing Monday-Sunday
  final int timesPerWeek; // For xTimesPerWeek frequency
  final int targetDuration; // In minutes, for duration goal type
  final int targetQuantity; // For quantity goal type
  final String reminderTime; // Format: "HH:MM"
  final String colorTag;
  final String icon;
  final bool isArchived;
  final DateTime createdAt;

  const Habit({
    required this.id,
    required this.title,
    this.description = '',
    required this.frequency,
    required this.goalType,
    this.specificDays = const [],
    this.timesPerWeek = 0,
    this.targetDuration = 0,
    this.targetQuantity = 0,
    this.reminderTime = '',
    this.colorTag = '',
    this.icon = '',
    this.isArchived = false,
    required this.createdAt,
  });

  /// Create a copy of this Habit with the given fields replaced with new values
  Habit copyWith({
    String? id,
    String? title,
    String? description,
    HabitFrequency? frequency,
    HabitGoalType? goalType,
    List<int>? specificDays,
    int? timesPerWeek,
    int? targetDuration,
    int? targetQuantity,
    String? reminderTime,
    String? colorTag,
    String? icon,
    bool? isArchived,
    DateTime? createdAt,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      goalType: goalType ?? this.goalType,
      specificDays: specificDays ?? this.specificDays,
      timesPerWeek: timesPerWeek ?? this.timesPerWeek,
      targetDuration: targetDuration ?? this.targetDuration,
      targetQuantity: targetQuantity ?? this.targetQuantity,
      reminderTime: reminderTime ?? this.reminderTime,
      colorTag: colorTag ?? this.colorTag,
      icon: icon ?? this.icon,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        frequency,
        goalType,
        specificDays,
        timesPerWeek,
        targetDuration,
        targetQuantity,
        reminderTime,
        colorTag,
        icon,
        isArchived,
        createdAt,
      ];
}
