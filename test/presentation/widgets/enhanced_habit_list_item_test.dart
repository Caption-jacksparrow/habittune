import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:habittune/domain/entities/habit.dart';
import 'package:habittune/presentation/bloc/habit_bloc.dart';
import 'package:habittune/presentation/widgets/enhanced_habit_list_item.dart';

import 'enhanced_habit_list_item_test.mocks.dart';

@GenerateMocks([HabitBloc])
void main() {
  group('EnhancedHabitListItem Widget Tests', () {
    late Habit testHabit;
    
    setUp(() {
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
    });
    
    testWidgets('should display habit title and description', (WidgetTester tester) async {
      bool itemTapped = false;
      
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedHabitListItem(
              habit: testHabit,
              onTap: () {
                itemTapped = true;
              },
              isCompleted: false,
            ),
          ),
        ),
      );

      // Verify that the title and description are displayed
      expect(find.text('Morning Meditation'), findsOneWidget);
      expect(find.text('Daily mindfulness practice'), findsOneWidget);
      expect(find.text('Daily'), findsOneWidget); // Frequency text
      
      // Tap the item
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      
      // Verify that the callback was called
      expect(itemTapped, true);
    });

    testWidgets('should display correct frequency text for specific days', (WidgetTester tester) async {
      // Create a habit with specific days
      final specificDaysHabit = testHabit.copyWith(
        frequency: HabitFrequency.specificDays,
        specificDays: [1, 3, 5], // Monday, Wednesday, Friday
      );
      
      // Build our widget with the specific days habit
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedHabitListItem(
              habit: specificDaysHabit,
              onTap: () {},
              isCompleted: false,
            ),
          ),
        ),
      );

      // Verify that the correct frequency text is displayed
      expect(find.text('On Mon, Wed, Fri'), findsOneWidget);
    });

    testWidgets('should display correct frequency text for times per week', (WidgetTester tester) async {
      // Create a habit with times per week
      final timesPerWeekHabit = testHabit.copyWith(
        frequency: HabitFrequency.xTimesPerWeek,
        timesPerWeek: 3,
      );
      
      // Build our widget with the times per week habit
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedHabitListItem(
              habit: timesPerWeekHabit,
              onTap: () {},
              isCompleted: false,
            ),
          ),
        ),
      );

      // Verify that the correct frequency text is displayed
      expect(find.text('3 times per week'), findsOneWidget);
    });

    testWidgets('should handle completion button tap', (WidgetTester tester) async {
      bool completionTapped = false;
      
      // Build our widget with completion callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EnhancedHabitListItem(
              habit: testHabit,
              onTap: () {},
              onComplete: () {
                completionTapped = true;
              },
              isCompleted: false,
            ),
          ),
        ),
      );

      // Find and tap the completion button
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      
      // Verify that the completion callback was called
      expect(completionTapped, true);
    });
  });
}
