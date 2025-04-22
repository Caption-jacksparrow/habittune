import 'package:hive/hive.dart';
import '../../domain/entities/habit.dart';

part 'habit_model.g.dart';

/// Model class for Habit with Hive support
@HiveType(typeId: 0)
class HabitModel extends Habit {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final int frequencyIndex;
  
  @HiveField(4)
  final int goalTypeIndex;
  
  @HiveField(5)
  final List<int> specificDays;
  
  @HiveField(6)
  final int timesPerWeek;
  
  @HiveField(7)
  final int targetDuration;
  
  @HiveField(8)
  final int targetQuantity;
  
  @HiveField(9)
  final String reminderTime;
  
  @HiveField(10)
  final String colorTag;
  
  @HiveField(11)
  final String icon;
  
  @HiveField(12)
  final bool isArchived;
  
  @HiveField(13)
  final DateTime createdAt;

  const HabitModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.frequencyIndex,
    required this.goalTypeIndex,
    this.specificDays = const [],
    this.timesPerWeek = 0,
    this.targetDuration = 0,
    this.targetQuantity = 0,
    this.reminderTime = '',
    this.colorTag = '',
    this.icon = '',
    this.isArchived = false,
    required this.createdAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          frequency: HabitFrequency.values[frequencyIndex],
          goalType: HabitGoalType.values[goalTypeIndex],
          specificDays: specificDays,
          timesPerWeek: timesPerWeek,
          targetDuration: targetDuration,
          targetQuantity: targetQuantity,
          reminderTime: reminderTime,
          colorTag: colorTag,
          icon: icon,
          isArchived: isArchived,
          createdAt: createdAt,
        );

  /// Create a HabitModel from a Habit entity
  factory HabitModel.fromEntity(Habit habit) {
    return HabitModel(
      id: habit.id,
      title: habit.title,
      description: habit.description,
      frequencyIndex: habit.frequency.index,
      goalTypeIndex: habit.goalType.index,
      specificDays: habit.specificDays,
      timesPerWeek: habit.timesPerWeek,
      targetDuration: habit.targetDuration,
      targetQuantity: habit.targetQuantity,
      reminderTime: habit.reminderTime,
      colorTag: habit.colorTag,
      icon: habit.icon,
      isArchived: habit.isArchived,
      createdAt: habit.createdAt,
    );
  }

  /// Convert this HabitModel to a Habit entity
  Habit toEntity() {
    return Habit(
      id: id,
      title: title,
      description: description,
      frequency: HabitFrequency.values[frequencyIndex],
      goalType: HabitGoalType.values[goalTypeIndex],
      specificDays: specificDays,
      timesPerWeek: timesPerWeek,
      targetDuration: targetDuration,
      targetQuantity: targetQuantity,
      reminderTime: reminderTime,
      colorTag: colorTag,
      icon: icon,
      isArchived: isArchived,
      createdAt: createdAt,
    );
  }

  /// Create a copy of this HabitModel with the given fields replaced with new values
  HabitModel copyWith({
    String? id,
    String? title,
    String? description,
    int? frequencyIndex,
    int? goalTypeIndex,
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
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      frequencyIndex: frequencyIndex ?? this.frequencyIndex,
      goalTypeIndex: goalTypeIndex ?? this.goalTypeIndex,
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
}
