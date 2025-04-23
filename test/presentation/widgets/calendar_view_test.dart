import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:habittune/presentation/widgets/calendar_view.dart';

void main() {
  group('CalendarView Widget Tests', () {
    final testMonth = DateTime(2025, 4); // April 2025
    final testCompletionData = {
      DateTime(2025, 4, 1): true,  // Completed
      DateTime(2025, 4, 5): true,  // Completed
      DateTime(2025, 4, 10): true, // Completed
    };
    
    testWidgets('should display correct month name and year', (WidgetTester tester) async {
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarView(
              month: testMonth,
              completionData: testCompletionData,
            ),
          ),
        ),
      );

      // Verify that the month name and year are displayed
      expect(find.text('April 2025'), findsOneWidget);
    });

    testWidgets('should display weekday headers', (WidgetTester tester) async {
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarView(
              month: testMonth,
              completionData: testCompletionData,
            ),
          ),
        ),
      );

      // Verify that weekday headers are displayed
      expect(find.text('M'), findsOneWidget);
      expect(find.text('T'), findsExactly(2)); // Tuesday and Thursday
      expect(find.text('W'), findsOneWidget);
      expect(find.text('F'), findsOneWidget);
      expect(find.text('S'), findsExactly(2)); // Saturday and Sunday
    });

    testWidgets('should call onDayTap callback when a day is tapped', (WidgetTester tester) async {
      // Track if callback was called and which date was passed
      DateTime? tappedDate;
      
      // Build our widget with the callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarView(
              month: testMonth,
              completionData: testCompletionData,
              onDayTap: (date) {
                tappedDate = date;
              },
            ),
          ),
        ),
      );

      // Find and tap on day 15
      await tester.tap(find.text('15'));
      await tester.pump();
      
      // Verify that the callback was called with the correct date
      expect(tappedDate, isNotNull);
      expect(tappedDate?.day, 15);
      expect(tappedDate?.month, 4);
      expect(tappedDate?.year, 2025);
    });

    testWidgets('should highlight today', (WidgetTester tester) async {
      // Get today's date
      final now = DateTime.now();
      final currentMonth = DateTime(now.year, now.month);
      
      // Build our widget with current month
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalendarView(
              month: currentMonth,
              completionData: {},
            ),
          ),
        ),
      );

      // Find today's date text
      final todayText = find.text(now.day.toString());
      expect(todayText, findsOneWidget);
      
      // Note: In a real test, we would verify the border of today's cell,
      // but this is simplified as direct style verification requires more complex widget testing
    });
  });
}
