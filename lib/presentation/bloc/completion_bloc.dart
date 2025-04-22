import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/habit_completion.dart';
import '../../../domain/repositories/habit_completion_repository.dart';

// Events
abstract class CompletionEvent extends Equatable {
  const CompletionEvent();

  @override
  List<Object?> get props => [];
}

class LoadCompletions extends CompletionEvent {
  final String habitId;

  const LoadCompletions(this.habitId);

  @override
  List<Object?> get props => [habitId];
}

class LoadCompletionsInRange extends CompletionEvent {
  final String habitId;
  final DateTime startDate;
  final DateTime endDate;

  const LoadCompletionsInRange(this.habitId, this.startDate, this.endDate);

  @override
  List<Object?> get props => [habitId, startDate, endDate];
}

class AddCompletion extends CompletionEvent {
  final HabitCompletion completion;

  const AddCompletion(this.completion);

  @override
  List<Object?> get props => [completion];
}

class DeleteCompletion extends CompletionEvent {
  final String completionId;

  const DeleteCompletion(this.completionId);

  @override
  List<Object?> get props => [completionId];
}

class LoadTodayCompletions extends CompletionEvent {}

class LoadStreak extends CompletionEvent {
  final String habitId;

  const LoadStreak(this.habitId);

  @override
  List<Object?> get props => [habitId];
}

// States
abstract class CompletionState extends Equatable {
  const CompletionState();

  @override
  List<Object?> get props => [];
}

class CompletionInitial extends CompletionState {}

class CompletionLoading extends CompletionState {}

class CompletionsLoaded extends CompletionState {
  final List<HabitCompletion> completions;

  const CompletionsLoaded(this.completions);

  @override
  List<Object?> get props => [completions];
}

class TodayCompletionsLoaded extends CompletionState {
  final List<HabitCompletion> completions;

  const TodayCompletionsLoaded(this.completions);

  @override
  List<Object?> get props => [completions];
}

class StreakLoaded extends CompletionState {
  final int currentStreak;
  final int longestStreak;

  const StreakLoaded(this.currentStreak, this.longestStreak);

  @override
  List<Object?> get props => [currentStreak, longestStreak];
}

class CompletionError extends CompletionState {
  final String message;

  const CompletionError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class CompletionBloc extends Bloc<CompletionEvent, CompletionState> {
  final HabitCompletionRepository completionRepository;

  CompletionBloc({required this.completionRepository}) : super(CompletionInitial()) {
    on<LoadCompletions>(_onLoadCompletions);
    on<LoadCompletionsInRange>(_onLoadCompletionsInRange);
    on<AddCompletion>(_onAddCompletion);
    on<DeleteCompletion>(_onDeleteCompletion);
    on<LoadTodayCompletions>(_onLoadTodayCompletions);
    on<LoadStreak>(_onLoadStreak);
  }

  Future<void> _onLoadCompletions(LoadCompletions event, Emitter<CompletionState> emit) async {
    emit(CompletionLoading());
    try {
      final completions = await completionRepository.getCompletionsForHabit(event.habitId);
      emit(CompletionsLoaded(completions));
    } catch (e) {
      emit(CompletionError(e.toString()));
    }
  }

  Future<void> _onLoadCompletionsInRange(LoadCompletionsInRange event, Emitter<CompletionState> emit) async {
    emit(CompletionLoading());
    try {
      final completions = await completionRepository.getCompletionsForHabitInRange(
        event.habitId,
        event.startDate,
        event.endDate,
      );
      emit(CompletionsLoaded(completions));
    } catch (e) {
      emit(CompletionError(e.toString()));
    }
  }

  Future<void> _onAddCompletion(AddCompletion event, Emitter<CompletionState> emit) async {
    try {
      await completionRepository.saveCompletion(event.completion);
      final completions = await completionRepository.getCompletionsForHabit(event.completion.habitId);
      emit(CompletionsLoaded(completions));
    } catch (e) {
      emit(CompletionError(e.toString()));
    }
  }

  Future<void> _onDeleteCompletion(DeleteCompletion event, Emitter<CompletionState> emit) async {
    try {
      await completionRepository.deleteCompletion(event.completionId);
      // Since we don't know the habit ID here, we'll just emit a success state
      // The UI should reload the appropriate data
      emit(CompletionInitial());
    } catch (e) {
      emit(CompletionError(e.toString()));
    }
  }

  Future<void> _onLoadTodayCompletions(LoadTodayCompletions event, Emitter<CompletionState> emit) async {
    emit(CompletionLoading());
    try {
      final completions = await completionRepository.getCompletionsForToday();
      emit(TodayCompletionsLoaded(completions));
    } catch (e) {
      emit(CompletionError(e.toString()));
    }
  }

  Future<void> _onLoadStreak(LoadStreak event, Emitter<CompletionState> emit) async {
    emit(CompletionLoading());
    try {
      final currentStreak = await completionRepository.getCurrentStreak(event.habitId);
      final longestStreak = await completionRepository.getLongestStreak(event.habitId);
      emit(StreakLoaded(currentStreak, longestStreak));
    } catch (e) {
      emit(CompletionError(e.toString()));
    }
  }
}
