import 'package:hive/hive.dart';
import '../../domain/entities/habit_completion.dart';

part 'habit_completion_model.g.dart';

/// Model class for HabitCompletion with Hive support
@HiveType(typeId: 1)
class HabitCompletionModel extends HabitCompletion {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String habitId;
  
  @HiveField(2)
  final DateTime completedAt;
  
  @HiveField(3)
  final int durationMinutes;
  
  @HiveField(4)
  final int quantity;
  
  @HiveField(5)
  final String notes;

  const HabitCompletionModel({
    required this.id,
    required this.habitId,
    required this.completedAt,
    this.durationMinutes = 0,
    this.quantity = 0,
    this.notes = '',
  }) : super(
          id: id,
          habitId: habitId,
          completedAt: completedAt,
          durationMinutes: durationMinutes,
          quantity: quantity,
          notes: notes,
        );

  /// Create a HabitCompletionModel from a HabitCompletion entity
  factory HabitCompletionModel.fromEntity(HabitCompletion completion) {
    return HabitCompletionModel(
      id: completion.id,
      habitId: completion.habitId,
      completedAt: completion.completedAt,
      durationMinutes: completion.durationMinutes,
      quantity: completion.quantity,
      notes: completion.notes,
    );
  }

  /// Convert this HabitCompletionModel to a HabitCompletion entity
  HabitCompletion toEntity() {
    return HabitCompletion(
      id: id,
      habitId: habitId,
      completedAt: completedAt,
      durationMinutes: durationMinutes,
      quantity: quantity,
      notes: notes,
    );
  }

  /// Create a copy of this HabitCompletionModel with the given fields replaced with new values
  HabitCompletionModel copyWith({
    String? id,
    String? habitId,
    DateTime? completedAt,
    int? durationMinutes,
    int? quantity,
    String? notes,
  }) {
    return HabitCompletionModel(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      completedAt: completedAt ?? this.completedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }
}
