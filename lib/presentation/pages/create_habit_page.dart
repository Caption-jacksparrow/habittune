import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../../domain/entities/habit.dart';
import '../../core/utils/uuid_generator.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key});

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  HabitFrequency _frequency = HabitFrequency.daily;
  HabitGoalType _goalType = HabitGoalType.yesNo;
  List<int> _selectedDays = [];
  int _timesPerWeek = 1;
  int _targetDuration = 10;
  int _targetQuantity = 1;
  String _reminderTime = '';
  String _colorTag = '#673AB7'; // Default to Deep Purple
  String _icon = 'check';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Habit'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Habit Title',
                  hintText: 'e.g., Morning Meditation',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Description field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'e.g., 10 minutes of mindfulness meditation',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              
              // Frequency selection
              const Text(
                'Frequency',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioListTile<HabitFrequency>(
                title: const Text('Daily'),
                value: HabitFrequency.daily,
                groupValue: _frequency,
                onChanged: (value) {
                  setState(() {
                    _frequency = value!;
                  });
                },
              ),
              RadioListTile<HabitFrequency>(
                title: const Text('Specific Days'),
                value: HabitFrequency.specificDays,
                groupValue: _frequency,
                onChanged: (value) {
                  setState(() {
                    _frequency = value!;
                  });
                },
              ),
              
              // Specific days selection (visible only when Specific Days is selected)
              if (_frequency == HabitFrequency.specificDays)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      for (int i = 1; i <= 7; i++)
                        FilterChip(
                          label: Text(_getDayName(i)),
                          selected: _selectedDays.contains(i),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedDays.add(i);
                              } else {
                                _selectedDays.remove(i);
                              }
                            });
                          },
                        ),
                    ],
                  ),
                ),
              
              RadioListTile<HabitFrequency>(
                title: const Text('X Times Per Week'),
                value: HabitFrequency.xTimesPerWeek,
                groupValue: _frequency,
                onChanged: (value) {
                  setState(() {
                    _frequency = value!;
                  });
                },
              ),
              
              // Times per week selection (visible only when X Times Per Week is selected)
              if (_frequency == HabitFrequency.xTimesPerWeek)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Text('Times per week: '),
                      DropdownButton<int>(
                        value: _timesPerWeek,
                        items: List.generate(7, (index) => index + 1)
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _timesPerWeek = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Goal type selection
              const Text(
                'Goal Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioListTile<HabitGoalType>(
                title: const Text('Yes/No Completion'),
                value: HabitGoalType.yesNo,
                groupValue: _goalType,
                onChanged: (value) {
                  setState(() {
                    _goalType = value!;
                  });
                },
              ),
              RadioListTile<HabitGoalType>(
                title: const Text('Duration-based'),
                value: HabitGoalType.duration,
                groupValue: _goalType,
                onChanged: (value) {
                  setState(() {
                    _goalType = value!;
                  });
                },
              ),
              
              // Duration selection (visible only when Duration-based is selected)
              if (_goalType == HabitGoalType.duration)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Text('Target duration (minutes): '),
                      DropdownButton<int>(
                        value: _targetDuration,
                        items: [5, 10, 15, 20, 30, 45, 60, 90, 120]
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _targetDuration = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              
              RadioListTile<HabitGoalType>(
                title: const Text('Quantity-based'),
                value: HabitGoalType.quantity,
                groupValue: _goalType,
                onChanged: (value) {
                  setState(() {
                    _goalType = value!;
                  });
                },
              ),
              
              // Quantity selection (visible only when Quantity-based is selected)
              if (_goalType == HabitGoalType.quantity)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Text('Target quantity: '),
                      DropdownButton<int>(
                        value: _targetQuantity,
                        items: List.generate(10, (index) => index + 1)
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _targetQuantity = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Color selection
              const Text(
                'Color Tag',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                children: [
                  _buildColorOption('#673AB7', 'Deep Purple'), // Primary brand color
                  _buildColorOption('#2196F3', 'Vibrant Blue'), // Secondary brand color
                  _buildColorOption('#4CAF50', 'Green'),
                  _buildColorOption('#FFC107', 'Amber'),
                  _buildColorOption('#FF5722', 'Deep Orange'),
                  _buildColorOption('#9C27B0', 'Purple'),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveHabit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Create Habit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorOption(String colorHex, String label) {
    final color = Color(int.parse(colorHex.replaceAll('#', '0xFF')));
    final isSelected = _colorTag == colorHex;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _colorTag = colorHex;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  String _getDayName(int day) {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    if (day >= 1 && day <= 7) {
      return dayNames[day - 1];
    }
    return '';
  }

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      // Create a new habit
      final habit = Habit(
        id: generateUuid(),
        title: _titleController.text,
        description: _descriptionController.text,
        frequency: _frequency,
        goalType: _goalType,
        specificDays: _selectedDays,
        timesPerWeek: _timesPerWeek,
        targetDuration: _targetDuration,
        targetQuantity: _targetQuantity,
        reminderTime: _reminderTime,
        colorTag: _colorTag,
        icon: _icon,
        createdAt: DateTime.now(),
      );
      
      // Add the habit using the BLoC
      BlocProvider.of<HabitBloc>(context).add(AddHabit(habit));
      
      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }
}
