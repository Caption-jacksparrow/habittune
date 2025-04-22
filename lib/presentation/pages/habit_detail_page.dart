import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/completion_bloc.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_completion.dart';
import '../../core/utils/uuid_generator.dart';
import '../widgets/progress_circle.dart';

class HabitDetailPage extends StatefulWidget {
  final Habit habit;

  const HabitDetailPage({super.key, required this.habit});

  @override
  State<HabitDetailPage> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load completions for this habit
    BlocProvider.of<CompletionBloc>(context).add(LoadCompletions(widget.habit.id));
    // Load streak information
    BlocProvider.of<CompletionBloc>(context).add(LoadStreak(widget.habit.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habit.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit habit page
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Habit summary card
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _getColorFromTag(widget.habit.colorTag),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.habit.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (widget.habit.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.habit.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.repeat, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          _getFrequencyText(widget.habit),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.flag, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          _getGoalText(widget.habit),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Streak information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<CompletionBloc, CompletionState>(
                    builder: (context, state) {
                      if (state is StreakLoaded) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text('Current Streak'),
                                Text(
                                  '${state.currentStreak} days',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Longest Streak'),
                                Text(
                                  '${state.longestStreak} days',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ),
            
            // Completion history
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Completion History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<CompletionBloc, CompletionState>(
                    builder: (context, state) {
                      if (state is CompletionsLoaded) {
                        if (state.completions.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text('No completions yet. Start building your streak!'),
                          );
                        }
                        
                        // Sort completions by date, most recent first
                        final sortedCompletions = List<HabitCompletion>.from(state.completions)
                          ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
                        
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sortedCompletions.length,
                          itemBuilder: (context, index) {
                            final completion = sortedCompletions[index];
                            return ListTile(
                              leading: const Icon(Icons.check_circle, color: Colors.green),
                              title: Text(
                                _formatDate(completion.completedAt),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: _buildCompletionDetails(completion),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  BlocProvider.of<CompletionBloc>(context)
                                      .add(DeleteCompletion(completion.id));
                                },
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _markAsCompleted(context);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.check, color: Colors.white),
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
    const dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    if (day >= 1 && day <= 7) {
      return dayNames[day - 1];
    }
    return '';
  }

  String _getGoalText(Habit habit) {
    switch (habit.goalType) {
      case HabitGoalType.yesNo:
        return 'Complete';
      case HabitGoalType.duration:
        return '${habit.targetDuration} minutes';
      case HabitGoalType.quantity:
        return '${habit.targetQuantity} times';
      default:
        return '';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildCompletionDetails(HabitCompletion completion) {
    if (widget.habit.goalType == HabitGoalType.duration && completion.durationMinutes > 0) {
      return Text('Duration: ${completion.durationMinutes} minutes');
    } else if (widget.habit.goalType == HabitGoalType.quantity && completion.quantity > 0) {
      return Text('Quantity: ${completion.quantity}');
    } else if (completion.notes.isNotEmpty) {
      return Text(completion.notes);
    }
    return const Text('Completed');
  }

  void _markAsCompleted(BuildContext context) {
    // Create a completion based on habit type
    final completion = HabitCompletion(
      id: generateUuid(),
      habitId: widget.habit.id,
      completedAt: DateTime.now(),
      durationMinutes: widget.habit.goalType == HabitGoalType.duration ? widget.habit.targetDuration : 0,
      quantity: widget.habit.goalType == HabitGoalType.quantity ? widget.habit.targetQuantity : 0,
    );
    
    // Save the completion
    BlocProvider.of<CompletionBloc>(context).add(AddCompletion(completion));
    
    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Habit marked as completed!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<HabitBloc>(context).add(DeleteHabit(widget.habit.id));
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
