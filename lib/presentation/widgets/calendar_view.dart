import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CalendarView extends StatelessWidget {
  final DateTime month;
  final Map<DateTime, bool> completionData;
  final Function(DateTime)? onDayTap;

  const CalendarView({
    super.key,
    required this.month,
    required this.completionData,
    this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday;
    
    // Adjust for Monday as first day of week (1-7 for Monday-Sunday)
    final adjustedFirstWeekday = firstWeekdayOfMonth;
    
    return Column(
      children: [
        // Month header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            _getMonthName(month.month) + ' ' + month.year.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _WeekdayLabel('M'),
            _WeekdayLabel('T'),
            _WeekdayLabel('W'),
            _WeekdayLabel('T'),
            _WeekdayLabel('F'),
            _WeekdayLabel('S'),
            _WeekdayLabel('S'),
          ],
        ),
        
        const SizedBox(height: 8),
        
        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: (adjustedFirstWeekday - 1) + daysInMonth,
          itemBuilder: (context, index) {
            // Empty cells for days before the first day of month
            if (index < (adjustedFirstWeekday - 1)) {
              return const SizedBox();
            }
            
            final day = index - (adjustedFirstWeekday - 1) + 1;
            final date = DateTime(month.year, month.month, day);
            final isToday = _isToday(date);
            final isCompleted = completionData[DateTime(date.year, date.month, date.day)] ?? false;
            
            return GestureDetector(
              onTap: () {
                if (onDayTap != null) {
                  onDayTap!(date);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isCompleted ? AppTheme.deepPurple.withOpacity(0.2) : Colors.transparent,
                  border: isToday
                      ? Border.all(color: AppTheme.deepPurple, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      day.toString(),
                      style: TextStyle(
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday ? AppTheme.deepPurple : null,
                      ),
                    ),
                    if (isCompleted)
                      Positioned(
                        bottom: 2,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppTheme.deepPurple,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;

  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
