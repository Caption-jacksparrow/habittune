import 'package:flutter/material.dart';
import '../../domain/entities/habit.dart';
import '../widgets/progress_circle.dart';

class HabitListItem extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;
  final VoidCallback? onComplete;

  const HabitListItem({
    super.key,
    required this.habit,
    required this.onTap,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Habit color indicator
              Container(
                width: 12,
                height: 48,
                decoration: BoxDecoration(
                  color: _getColorFromTag(habit.colorTag),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 16),
              
              // Habit details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getFrequencyText(habit),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Completion button
              IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: onComplete,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorFromTag(String colorTag) {
    // Default to primary color if no tag is specified
    if (colorTag.isEmpty) {
      return const Color(0xFF673AB7); // Deep Purple
    }
    
    // Parse hex color
    try {
      return Color(int.parse(colorTag.replaceAll('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF673AB7); // Deep Purple as fallback
    }
  }

  String _getFrequencyText(Habit habit) {
    switch (habit.frequency) {
      case HabitFrequency.daily:
        return 'Daily';
      case HabitFrequency.specificDays:
        final days = habit.specificDays.map(_getDayName).join(', ');
        return 'On $days';
      case HabitFrequency.xTimesPerWeek:
        return '${habit.timesPerWeek} times per week';
      default:
        return '';
    }
  }

  String _getDayName(int day) {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (day >= 1 && day <= 7) {
      return dayNames[day - 1];
    }
    return '';
  }
}
