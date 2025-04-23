import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:habittune/domain/entities/habit.dart';
import 'package:habittune/domain/entities/habit_completion.dart';
import 'package:habittune/presentation/bloc/habit_bloc.dart';
import 'package:habittune/presentation/bloc/completion_bloc.dart';
import 'package:habittune/presentation/pages/habit_detail_page.dart';

import 'habit_detail_page_test.mocks.dart';

@GenerateMocks([HabitBloc, CompletionBloc])
void main() {
  group('HabitDetailPage Widget Tests', () {
    late MockHabitBloc mockHabitBloc;
    late MockCompletionBloc mockCompletionBloc;
    late Habit testHabit;
    
    setUp(() {
      mockHabitBloc = MockHabitBloc();
      mockCompletionBloc = MockCompletionBloc();
      
      testHabit = Habit(
        id: 'test-habit-id',
        title: 'Morning Meditation',
        description: 'Daily mindfulness practice',
        frequency: HabitFrequency.daily,
        goalType: HabitGoalType.duration,
        specificDays: const [],
        timesPerWeek: 0,
        targetDuration: 10,
        targetQuantity: 0,
        reminderTime: '',
        colorTag: '#673AB7',
        icon: 'meditation',
        createdAt: DateTime(2025, 4, 22),
      );
      
      // Set up default states
      when(mockHabitBloc.state).thenReturn(HabitInitial());
      when(mockCompletionBloc.state).thenReturn(CompletionInitial());
    });
    
    testWidgets('should display habit details', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: HabitDetailPage(habit: testHabit),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Morning Meditation'), findsOneWidget);
      expect(find.text('Daily mindfulness practice'), findsOneWidget);
      expect(find.text('Frequency: Daily'), findsOneWidget);
      expect(find.text('Goal: 10 minutes'), findsOneWidget);
    });
    
    testWidgets('should display streak information', (WidgetTester tester) async {
      // Arrange
      when(mockCompletionBloc.state).thenReturn(const StreakLoaded(currentStreak: 5, longestStreak: 10));
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: HabitDetailPage(habit: testHabit),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Current Streak'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('Longest Streak'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
    });
    
    testWidgets('should display completion history', (WidgetTester tester) async {
      // Arrange
      final testCompletions = [
        HabitCompletion(
          id: 'completion-1',
          habitId: testHabit.id,
          completedAt: DateTime(2025, 4, 22, 10, 30),
          durationMinutes: 15,
          quantity: 0,
          notes: 'Felt great today',
        ),
        HabitCompletion(
          id: 'completion-2',
          habitId: testHabit.id,
          completedAt: DateTime(2025, 4, 21, 9, 45),
          durationMinutes: 12,
          quantity: 0,
          notes: '',
        ),
      ];
      
      when(mockCompletionBloc.state).thenReturn(CompletionsLoaded(testCompletions));
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: HabitDetailPage(habit: testHabit),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Completion History'), findsOneWidget);
      expect(find.text('April 22, 2025'), findsOneWidget);
      expect(find.text('15 minutes'), findsOneWidget);
      expect(find.text('Felt great today'), findsOneWidget);
      expect(find.text('April 21, 2025'), findsOneWidget);
      expect(find.text('12 minutes'), findsOneWidget);
    });
    
    testWidgets('should display calendar view', (WidgetTester tester) async {
      // Arrange
      final testCompletions = [
        HabitCompletion(
          id: 'completion-1',
          habitId: testHabit.id,
          completedAt: DateTime(2025, 4, 22),
          durationMinutes: 15,
          quantity: 0,
          notes: '',
        ),
      ];
      
      when(mockCompletionBloc.state).thenReturn(CompletionsLoaded(testCompletions));
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: HabitDetailPage(habit: testHabit),
          ),
        ),
      );
      
      // Assert
      expect(find.text('April 2025'), findsOneWidget);
      // Calendar should show weekday headers
      expect(find.text('M'), findsOneWidget);
      expect(find.text('T'), findsAtLeastNWidgets(1));
      expect(find.text('W'), findsOneWidget);
    });
  });
}
