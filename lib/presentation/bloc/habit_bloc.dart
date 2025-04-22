import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/habit.dart';
import '../../../domain/repositories/habit_repository.dart';

// Events
abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object?> get props => [];
}

class LoadHabits extends HabitEvent {}

class AddHabit extends HabitEvent {
  final Habit habit;

  const AddHabit(this.habit);

  @override
  List<Object?> get props => [habit];
}

class UpdateHabit extends HabitEvent {
  final Habit habit;

  const UpdateHabit(this.habit);

  @override
  List<Object?> get props => [habit];
}

class DeleteHabit extends HabitEvent {
  final String habitId;

  const DeleteHabit(this.habitId);

  @override
  List<Object?> get props => [habitId];
}

class ArchiveHabit extends HabitEvent {
  final String habitId;

  const ArchiveHabit(this.habitId);

  @override
  List<Object?> get props => [habitId];
}

class LoadTodayHabits extends HabitEvent {}

// States
abstract class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object?> get props => [];
}

class HabitInitial extends HabitState {}

class HabitLoading extends HabitState {}

class HabitsLoaded extends HabitState {
  final List<Habit> habits;

  const HabitsLoaded(this.habits);

  @override
  List<Object?> get props => [habits];
}

class TodayHabitsLoaded extends HabitState {
  final List<Habit> habits;

  const TodayHabitsLoaded(this.habits);

  @override
  List<Object?> get props => [habits];
}

class HabitError extends HabitState {
  final String message;

  const HabitError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository habitRepository;

  HabitBloc({required this.habitRepository}) : super(HabitInitial()) {
    on<LoadHabits>(_onLoadHabits);
    on<AddHabit>(_onAddHabit);
    on<UpdateHabit>(_onUpdateHabit);
    on<DeleteHabit>(_onDeleteHabit);
    on<ArchiveHabit>(_onArchiveHabit);
    on<LoadTodayHabits>(_onLoadTodayHabits);
  }

  Future<void> _onLoadHabits(LoadHabits event, Emitter<HabitState> emit) async {
    emit(HabitLoading());
    try {
      final habits = await habitRepository.getHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitError(e.toString()));
    }
  }

  Future<void> _onAddHabit(AddHabit event, Emitter<HabitState> emit) async {
    try {
      await habitRepository.saveHabit(event.habit);
      final habits = await habitRepository.getHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitError(e.toString()));
    }
  }

  Future<void> _onUpdateHabit(UpdateHabit event, Emitter<HabitState> emit) async {
    try {
      await habitRepository.saveHabit(event.habit);
      final habits = await habitRepository.getHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitError(e.toString()));
    }
  }

  Future<void> _onDeleteHabit(DeleteHabit event, Emitter<HabitState> emit) async {
    try {
      await habitRepository.deleteHabit(event.habitId);
      final habits = await habitRepository.getHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitError(e.toString()));
    }
  }

  Future<void> _onArchiveHabit(ArchiveHabit event, Emitter<HabitState> emit) async {
    try {
      await habitRepository.archiveHabit(event.habitId);
      final habits = await habitRepository.getHabits();
      emit(HabitsLoaded(habits));
    } catch (e) {
      emit(HabitError(e.toString()));
    }
  }

  Future<void> _onLoadTodayHabits(LoadTodayHabits event, Emitter<HabitState> emit) async {
    emit(HabitLoading());
    try {
      final habits = await habitRepository.getHabitsForToday();
      emit(TodayHabitsLoaded(habits));
    } catch (e) {
      emit(HabitError(e.toString()));
    }
  }
}
