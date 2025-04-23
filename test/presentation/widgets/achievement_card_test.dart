import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:habittune/presentation/widgets/achievement_card.dart';
import 'package:habittune/domain/entities/achievement.dart';

void main() {
  group('AchievementCard Widget Tests', () {
    testWidgets('should display unlocked achievement correctly', (WidgetTester tester) async {
      // Create an unlocked achievement
      final unlockedAchievement = Achievement(
        id: 'achievement-1',
        title: 'Early Bird',
        description: 'Complete a habit before 8 AM for 5 consecutive days',
        category: 'consistency',
        icon: 'star',
        isUnlocked: true,
        unlockedAt: DateTime(2025, 4, 20),
        createdAt: DateTime(2025, 4, 1),
      );
      
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AchievementCard(
                achievement: unlockedAchievement,
              ),
            ),
          ),
        ),
      );

      // Verify that the achievement details are displayed correctly
      expect(find.text('Early Bird'), findsOneWidget);
      expect(find.text('Complete a habit before 8 AM for 5 consecutive days'), findsOneWidget);
      expect(find.text('Unlocked'), findsOneWidget);
      expect(find.text('Unlocked on 2025-04-20'), findsOneWidget);
    });

    testWidgets('should display locked achievement correctly', (WidgetTester tester) async {
      // Create a locked achievement
      final lockedAchievement = Achievement(
        id: 'achievement-2',
        title: 'Night Owl',
        description: 'Complete a habit after 10 PM for 5 consecutive days',
        category: 'consistency',
        icon: 'star',
        isUnlocked: false,
        unlockedAt: null,
        createdAt: DateTime(2025, 4, 1),
      );
      
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AchievementCard(
                achievement: lockedAchievement,
              ),
            ),
          ),
        ),
      );

      // Verify that the achievement details are displayed correctly
      expect(find.text('Night Owl'), findsOneWidget);
      expect(find.text('Complete a habit after 10 PM for 5 consecutive days'), findsOneWidget);
      expect(find.text('Locked'), findsOneWidget);
      expect(find.text('Unlocked on 2025-04-20'), findsNothing); // Should not show unlock date
    });

    testWidgets('should call onTap callback when tapped', (WidgetTester tester) async {
      // Track if callback was called
      bool wasTapped = false;
      
      // Create an achievement
      final achievement = Achievement(
        id: 'achievement-1',
        title: 'Early Bird',
        description: 'Complete a habit before 8 AM for 5 consecutive days',
        category: 'consistency',
        icon: 'star',
        isUnlocked: true,
        unlockedAt: DateTime(2025, 4, 20),
        createdAt: DateTime(2025, 4, 1),
      );
      
      // Build our widget with the callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AchievementCard(
                achievement: achievement,
                onTap: () {
                  wasTapped = true;
                },
              ),
            ),
          ),
        ),
      );

      // Find and tap the card
      await tester.tap(find.byType(InkWell));
      await tester.pump();
      
      // Verify that the callback was called
      expect(wasTapped, true);
    });

    testWidgets('should display different icons based on icon property', (WidgetTester tester) async {
      // Create achievements with different icons
      final trophyAchievement = Achievement(
        id: 'trophy-achievement',
        title: 'Trophy Achievement',
        description: 'Description',
        category: 'milestone',
        icon: 'trophy',
        isUnlocked: true,
        unlockedAt: DateTime(2025, 4, 20),
        createdAt: DateTime(2025, 4, 1),
      );
      
      // Build our widget with trophy icon
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AchievementCard(
                achievement: trophyAchievement,
              ),
            ),
          ),
        ),
      );

      // Verify that the trophy icon is displayed
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
      
      // Create a star achievement
      final starAchievement = Achievement(
        id: 'star-achievement',
        title: 'Star Achievement',
        description: 'Description',
        category: 'milestone',
        icon: 'star',
        isUnlocked: true,
        unlockedAt: DateTime(2025, 4, 20),
        createdAt: DateTime(2025, 4, 1),
      );
      
      // Build our widget with star icon
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AchievementCard(
                achievement: starAchievement,
              ),
            ),
          ),
        ),
      );

      // Verify that the star icon is displayed
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });
}
