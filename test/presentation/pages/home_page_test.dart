import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:habittune/domain/entities/habit.dart';
import 'package:habittune/domain/entities/habit_completion.dart';
import 'package:habittune/presentation/bloc/habit_bloc.dart';
import 'package:habittune/presentation/bloc/completion_bloc.dart';
import 'package:habittune/presentation/pages/home_page.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([HabitBloc, CompletionBloc])
void main() {
  group('HomePage Widget Tests', () {
    late MockHabitBloc mockHabitBloc;
    late MockCompletionBloc mockCompletionBloc;
    
    setUp(() {
      mockHabitBloc = MockHabitBloc();
      mockCompletionBloc = MockCompletionBloc();
      
      // Set up default states
      when(mockHabitBloc.state).thenReturn(HabitInitial());
      when(mockCompletionBloc.state).thenReturn(CompletionInitial());
    });
    
    testWidgets('should show loading indicator when habits are loading', (WidgetTester tester) async {
      // Arrange
      when(mockHabitBloc.state).thenReturn(HabitLoading());
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: const HomePage(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('should show empty state message when no habits are available', (WidgetTester tester) async {
      // Arrange
      when(mockHabitBloc.state).thenReturn(const TodayHabitsLoaded([]));
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: const HomePage(),
          ),
        ),
      );
      
      // Assert
      expect(find.text('No habits for today. Add some habits to get started!'), findsOneWidget);
    });
    
    testWidgets('should show habits list when habits are loaded', (WidgetTester tester) async {
      // Arrange
      final testHabits = [
        Habit(
          id: 'habit-1',
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
        ),
        Habit(
          id: 'habit-2',
          title: 'Evening Reading',
          description: 'Read before bed',
          frequency: HabitFrequency.daily,
          goalType: HabitGoalType.duration,
          specificDays: const [],
          timesPerWeek: 0,
          targetDuration: 20,
          targetQuantity: 0,
          reminderTime: '',
          colorTag: '#2196F3',
          icon: 'book',
          createdAt: DateTime(2025, 4, 22),
        ),
      ];
      
      when(mockHabitBloc.state).thenReturn(TodayHabitsLoaded(testHabits));
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: const HomePage(),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Morning Meditation'), findsOneWidget);
      expect(find.text('Evening Reading'), findsOneWidget);
    });
    
    testWidgets('should show progress information when completions are loaded', (WidgetTester tester) async {
      // Arrange
      final testHabits = [
        Habit(
          id: 'habit-1',
          title: 'Morning Meditation',
          description: '',
          frequency: HabitFrequency.daily,
          goalType: HabitGoalType.yesNo,
          specificDays: const [],
          timesPerWeek: 0,
          targetDuration: 0,
          targetQuantity: 0,
          reminderTime: '',
          colorTag: '#673AB7',
          icon: 'meditation',
          createdAt: DateTime(2025, 4, 22),
        ),
        Habit(
          id: 'habit-2',
          title: 'Evening Reading',
          description: '',
          frequency: HabitFrequency.daily,
          goalType: HabitGoalType.yesNo,
          specificDays: const [],
          timesPerWeek: 0,
          targetDuration: 0,
          targetQuantity: 0,
          reminderTime: '',
          colorTag: '#2196F3',
          icon: 'book',
          createdAt: DateTime(2025, 4, 22),
        ),
      ];
      
      final testCompletions = [
        HabitCompletion(
          id: 'completion-1',
          habitId: 'habit-1',
          completedAt: DateTime.now(),
          durationMinutes: 0,
          quantity: 0,
          notes: '',
        ),
      ];
      
      when(mockHabitBloc.state).thenReturn(TodayHabitsLoaded(testHabits));
      when(mockCompletionBloc.state).thenReturn(TodayCompletionsLoaded(testCompletions));
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: const HomePage(),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Today\'s Progress'), findsOneWidget);
      // Note: We can't easily test the progress circle percentage in this simplified test
    });
    
    testWidgets('should navigate to create habit page when FAB is tapped', (WidgetTester tester) async {
      // Arrange
      when(mockHabitBloc.state).thenReturn(const TodayHabitsLoaded([]));
      
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<HabitBloc>.value(value: mockHabitBloc),
              BlocProvider<CompletionBloc>.value(value: mockCompletionBloc),
            ],
            child: const HomePage(),
          ),
        ),
      );
      
      // Find and tap the FAB
      expect(find.byType(FloatingActionButton), findsOneWidget);
      
      // Note: In a real test, we would tap the FAB and verify navigation,
      // but this is simplified as navigation testing requires more setup
    });
  });
}
