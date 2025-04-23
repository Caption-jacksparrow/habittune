import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:habittune/domain/entities/habit.dart';
import 'package:habittune/presentation/bloc/habit_bloc.dart';
import 'package:habittune/presentation/pages/create_habit_page.dart';

import 'create_habit_page_test.mocks.dart';

@GenerateMocks([HabitBloc])
void main() {
  group('CreateHabitPage Widget Tests', () {
    late MockHabitBloc mockHabitBloc;
    
    setUp(() {
      mockHabitBloc = MockHabitBloc();
      when(mockHabitBloc.state).thenReturn(HabitInitial());
    });
    
    testWidgets('should render form fields correctly', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: const CreateHabitPage(),
          ),
        ),
      );
      
      // Assert - Check for form fields
      expect(find.text('Create New Habit'), findsOneWidget);
      expect(find.text('Habit Title'), findsOneWidget);
      expect(find.text('Description (Optional)'), findsOneWidget);
      expect(find.text('Frequency'), findsOneWidget);
      expect(find.text('Daily'), findsOneWidget);
      expect(find.text('Specific Days'), findsOneWidget);
      expect(find.text('X Times Per Week'), findsOneWidget);
      expect(find.text('Goal Type'), findsOneWidget);
      expect(find.text('Yes/No Completion'), findsOneWidget);
      expect(find.text('Duration-based'), findsOneWidget);
      expect(find.text('Quantity-based'), findsOneWidget);
      expect(find.text('Color Tag'), findsOneWidget);
      expect(find.text('Create Habit'), findsOneWidget);
    });
    
    testWidgets('should show specific days selection when that frequency is selected', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: const CreateHabitPage(),
          ),
        ),
      );
      
      // Initially, specific days selection should not be visible
      expect(find.text('Mon'), findsNothing);
      
      // Tap on Specific Days radio button
      await tester.tap(find.text('Specific Days'));
      await tester.pump();
      
      // Now specific days selection should be visible
      expect(find.text('Mon'), findsOneWidget);
      expect(find.text('Tue'), findsOneWidget);
      expect(find.text('Wed'), findsOneWidget);
      expect(find.text('Thu'), findsOneWidget);
      expect(find.text('Fri'), findsOneWidget);
      expect(find.text('Sat'), findsOneWidget);
      expect(find.text('Sun'), findsOneWidget);
    });
    
    testWidgets('should show times per week selection when that frequency is selected', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: const CreateHabitPage(),
          ),
        ),
      );
      
      // Initially, times per week selection should not be visible
      expect(find.text('Times per week:'), findsNothing);
      
      // Tap on X Times Per Week radio button
      await tester.tap(find.text('X Times Per Week'));
      await tester.pump();
      
      // Now times per week selection should be visible
      expect(find.text('Times per week:'), findsOneWidget);
    });
    
    testWidgets('should show duration selection when duration-based goal type is selected', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: const CreateHabitPage(),
          ),
        ),
      );
      
      // Initially, duration selection should not be visible
      expect(find.text('Target duration (minutes):'), findsNothing);
      
      // Tap on Duration-based radio button
      await tester.tap(find.text('Duration-based'));
      await tester.pump();
      
      // Now duration selection should be visible
      expect(find.text('Target duration (minutes):'), findsOneWidget);
    });
    
    testWidgets('should show quantity selection when quantity-based goal type is selected', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: const CreateHabitPage(),
          ),
        ),
      );
      
      // Initially, quantity selection should not be visible
      expect(find.text('Target quantity:'), findsNothing);
      
      // Tap on Quantity-based radio button
      await tester.tap(find.text('Quantity-based'));
      await tester.pump();
      
      // Now quantity selection should be visible
      expect(find.text('Target quantity:'), findsOneWidget);
    });
    
    testWidgets('should validate form and show error when title is empty', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: const CreateHabitPage(),
          ),
        ),
      );
      
      // Tap the Create Habit button without entering a title
      await tester.tap(find.text('Create Habit'));
      await tester.pump();
      
      // Should show validation error
      expect(find.text('Please enter a title'), findsOneWidget);
    });
    
    testWidgets('should create habit when form is valid', (WidgetTester tester) async {
      // Act - Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HabitBloc>.value(
            value: mockHabitBloc,
            child: const CreateHabitPage(),
          ),
        ),
      );
      
      // Enter a title
      await tester.enterText(find.widgetWithText(TextFormField, 'Habit Title'), 'Test Habit');
      
      // Tap the Create Habit button
      await tester.tap(find.text('Create Habit'));
      await tester.pump();
      
      // Verify that AddHabit event was added to the bloc
      verify(mockHabitBloc.add(any)).called(1);
    });
  });
}
