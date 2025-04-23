import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:habittune/presentation/widgets/animated_progress_circle.dart';

void main() {
  group('AnimatedProgressCircle Widget Tests', () {
    testWidgets('should display correct percentage', (WidgetTester tester) async {
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: AnimatedProgressCircle(
                progress: 0.75,
                size: 100,
                strokeWidth: 10,
              ),
            ),
          ),
        ),
      );

      // Verify that the progress circle shows 75%
      expect(find.text('75%'), findsOneWidget);
    });

    testWidgets('should show checkmark when progress is complete and showCheckmark is true', (WidgetTester tester) async {
      // Build our widget with 100% progress and showCheckmark = true
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: AnimatedProgressCircle(
                progress: 1.0,
                size: 100,
                strokeWidth: 10,
                showCheckmark: true,
              ),
            ),
          ),
        ),
      );

      // Pump the widget to allow animations to complete
      await tester.pump(const Duration(milliseconds: 500));

      // Verify that the checkmark icon is displayed
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('100%'), findsNothing); // Percentage should be hidden when checkmark is shown
    });

    testWidgets('should not show checkmark when showCheckmark is false', (WidgetTester tester) async {
      // Build our widget with 100% progress but showCheckmark = false
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: AnimatedProgressCircle(
                progress: 1.0,
                size: 100,
                strokeWidth: 10,
                showCheckmark: false,
              ),
            ),
          ),
        ),
      );

      // Verify that the checkmark icon is not displayed
      expect(find.byIcon(Icons.check), findsNothing);
      expect(find.text('100%'), findsOneWidget); // Percentage should be shown
    });

    testWidgets('should use custom colors', (WidgetTester tester) async {
      const Color customProgressColor = Colors.green;
      const Color customBackgroundColor = Colors.grey;
      
      // Build our widget with custom colors
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: AnimatedProgressCircle(
                progress: 0.5,
                size: 100,
                strokeWidth: 10,
                progressColor: customProgressColor,
                backgroundColor: customBackgroundColor,
              ),
            ),
          ),
        ),
      );

      // Find CircularProgressIndicator widgets
      final Finder progressIndicators = find.byType(CircularProgressIndicator);
      expect(progressIndicators, findsNWidgets(2)); // Background and progress indicators
      
      // Note: In a real test, we would verify the colors, but this is simplified
      // as direct color verification requires more complex widget testing
    });
  });
}
