import 'package:equatable/equatable.dart';

/// Represents a habit completion record
class HabitCompletion extends Equatable {
  final String id;
  final String habitId;
  final DateTime completedAt;
  final int durationMinutes; // For duration-based habits
  final int quantity; // For quantity-based habits
  final String notes;

  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.completedAt,
    this.durationMinutes = 0,
    this.quantity = 0,
    this.notes = '',
  });

  /// Create a copy of this HabitCompletion with the given fields replaced with new values
  HabitCompletion copyWith({
    String? id,
    String? habitId,
    DateTime? completedAt,
    int? durationMinutes,
    int? quantity,
    String? notes,
  }) {
    return HabitCompletion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      completedAt: completedAt ?? this.completedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        habitId,
        completedAt,
        durationMinutes,
        quantity,
        notes,
      ];
}
