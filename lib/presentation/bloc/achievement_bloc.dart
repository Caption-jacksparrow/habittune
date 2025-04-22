import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/achievement.dart';
import '../../../domain/repositories/achievement_repository.dart';

// Events
abstract class AchievementEvent extends Equatable {
  const AchievementEvent();

  @override
  List<Object?> get props => [];
}

class LoadAchievements extends AchievementEvent {}

class LoadUnlockedAchievements extends AchievementEvent {}

class LoadLockedAchievements extends AchievementEvent {}

class LoadAchievementsByCategory extends AchievementEvent {
  final String category;

  const LoadAchievementsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class UnlockAchievement extends AchievementEvent {
  final String achievementId;

  const UnlockAchievement(this.achievementId);

  @override
  List<Object?> get props => [achievementId];
}

// States
abstract class AchievementState extends Equatable {
  const AchievementState();

  @override
  List<Object?> get props => [];
}

class AchievementInitial extends AchievementState {}

class AchievementLoading extends AchievementState {}

class AllAchievementsLoaded extends AchievementState {
  final List<Achievement> achievements;

  const AllAchievementsLoaded(this.achievements);

  @override
  List<Object?> get props => [achievements];
}

class UnlockedAchievementsLoaded extends AchievementState {
  final List<Achievement> achievements;

  const UnlockedAchievementsLoaded(this.achievements);

  @override
  List<Object?> get props => [achievements];
}

class LockedAchievementsLoaded extends AchievementState {
  final List<Achievement> achievements;

  const LockedAchievementsLoaded(this.achievements);

  @override
  List<Object?> get props => [achievements];
}

class CategoryAchievementsLoaded extends AchievementState {
  final List<Achievement> achievements;
  final String category;

  const CategoryAchievementsLoaded(this.achievements, this.category);

  @override
  List<Object?> get props => [achievements, category];
}

class AchievementError extends AchievementState {
  final String message;

  const AchievementError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  final AchievementRepository achievementRepository;

  AchievementBloc({required this.achievementRepository}) : super(AchievementInitial()) {
    on<LoadAchievements>(_onLoadAchievements);
    on<LoadUnlockedAchievements>(_onLoadUnlockedAchievements);
    on<LoadLockedAchievements>(_onLoadLockedAchievements);
    on<LoadAchievementsByCategory>(_onLoadAchievementsByCategory);
    on<UnlockAchievement>(_onUnlockAchievement);
  }

  Future<void> _onLoadAchievements(LoadAchievements event, Emitter<AchievementState> emit) async {
    emit(AchievementLoading());
    try {
      final achievements = await achievementRepository.getAchievements();
      emit(AllAchievementsLoaded(achievements));
    } catch (e) {
      emit(AchievementError(e.toString()));
    }
  }

  Future<void> _onLoadUnlockedAchievements(LoadUnlockedAchievements event, Emitter<AchievementState> emit) async {
    emit(AchievementLoading());
    try {
      final achievements = await achievementRepository.getUnlockedAchievements();
      emit(UnlockedAchievementsLoaded(achievements));
    } catch (e) {
      emit(AchievementError(e.toString()));
    }
  }

  Future<void> _onLoadLockedAchievements(LoadLockedAchievements event, Emitter<AchievementState> emit) async {
    emit(AchievementLoading());
    try {
      final achievements = await achievementRepository.getLockedAchievements();
      emit(LockedAchievementsLoaded(achievements));
    } catch (e) {
      emit(AchievementError(e.toString()));
    }
  }

  Future<void> _onLoadAchievementsByCategory(LoadAchievementsByCategory event, Emitter<AchievementState> emit) async {
    emit(AchievementLoading());
    try {
      final achievements = await achievementRepository.getAchievementsByCategory(event.category);
      emit(CategoryAchievementsLoaded(achievements, event.category));
    } catch (e) {
      emit(AchievementError(e.toString()));
    }
  }

  Future<void> _onUnlockAchievement(UnlockAchievement event, Emitter<AchievementState> emit) async {
    try {
      await achievementRepository.unlockAchievement(event.achievementId);
      final achievements = await achievementRepository.getAchievements();
      emit(AllAchievementsLoaded(achievements));
    } catch (e) {
      emit(AchievementError(e.toString()));
    }
  }
}
