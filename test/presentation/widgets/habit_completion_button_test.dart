import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittune/core/theme/app_theme.dart';
import 'package:habittune/presentation/widgets/habit_completion_button.dart';

void main() {
  group('HabitCompletionButton Widget Tests', () {
    testWidgets('should display add icon when not completed', (WidgetTester tester) async {
      bool buttonPressed = false;
      
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getLightTheme(),
          home: Scaffold(
            body: Center(
              child: HabitCompletionButton(
                onPressed: () {
                  buttonPressed = true;
                },
                isCompleted: false,
              ),
            ),
          ),
        ),
      );

      // Verify that the add icon is displayed
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
      
      // Tap the button
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      
      // Verify that the callback was called
      expect(buttonPressed, true);
    });

    testWidgets('should display check icon when completed', (WidgetTester tester) async {
      // Build our widget with isCompleted = true
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getLightTheme(),
          home: Scaffold(
            body: Center(
              child: HabitCompletionButton(
                onPressed: () {},
                isCompleted: true,
              ),
            ),
          ),
        ),
      );

      // Verify that the check icon is displayed
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);
    });

    testWidgets('should have correct styling based on completion state', (WidgetTester tester) async {
      // Build our widget with isCompleted = false
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getLightTheme(),
          home: Scaffold(
            body: Center(
              child: HabitCompletionButton(
                onPressed: () {},
                isCompleted: false,
                size: 60,
              ),
            ),
          ),
        ),
      );

      // Find the container
      final Finder containerFinder = find.byType(Container).first;
      final Container container = tester.widget(containerFinder);
      
      // Verify container size
      expect(container.constraints?.constraints.maxWidth, 60);
      expect(container.constraints?.constraints.maxHeight, 60);
      
      // Verify border (simplified check)
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      
      // Build our widget with isCompleted = true
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getLightTheme(),
          home: Scaffold(
            body: Center(
              child: HabitCompletionButton(
                onPressed: () {},
                isCompleted: true,
                size: 60,
              ),
            ),
          ),
        ),
      );
      
      // Find the container again
      final Finder completedContainerFinder = find.byType(Container).first;
      final Container completedContainer = tester.widget(completedContainerFinder);
      
      // Verify container size remains the same
      expect(completedContainer.constraints?.constraints.maxWidth, 60);
      expect(completedContainer.constraints?.constraints.maxHeight, 60);
    });
  });
}
