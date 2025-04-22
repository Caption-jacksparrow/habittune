import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/habit_bloc.dart';
import '../bloc/completion_bloc.dart';
import '../bloc/achievement_bloc.dart';
import '../../injection/injection_container.dart';
import '../../domain/entities/habit.dart';
import 'habit_detail_page.dart';
import 'create_habit_page.dart';
import '../widgets/habit_list_item.dart';
import '../widgets/progress_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load today's habits when the page is initialized
    BlocProvider.of<HabitBloc>(context).add(LoadTodayHabits());
    // Load today's completions
    BlocProvider.of<CompletionBloc>(context).add(LoadTodayCompletions());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HabitBloc>()),
        BlocProvider(create: (_) => sl<CompletionBloc>()),
        BlocProvider(create: (_) => sl<AchievementBloc>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HabitTune'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.insights),
              onPressed: () {
                // Navigate to insights page
              },
            ),
            IconButton(
              icon: const Icon(Icons.emoji_events),
              onPressed: () {
                // Navigate to achievements page
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // Progress summary section
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('Today\'s Progress'),
                      BlocBuilder<CompletionBloc, CompletionState>(
                        builder: (context, state) {
                          if (state is TodayCompletionsLoaded) {
                            return BlocBuilder<HabitBloc, HabitState>(
                              builder: (context, habitState) {
                                if (habitState is TodayHabitsLoaded) {
                                  final completionCount = state.completions.length;
                                  final habitCount = habitState.habits.length;
                                  final progress = habitCount > 0 
                                      ? completionCount / habitCount 
                                      : 0.0;
                                  
                                  return ProgressCircle(
                                    progress: progress,
                                    size: 80,
                                    strokeWidth: 8,
                                  );
                                }
                                return const ProgressCircle(
                                  progress: 0,
                                  size: 80,
                                  strokeWidth: 8,
                                );
                              },
                            );
                          }
                          return const ProgressCircle(
                            progress: 0,
                            size: 80,
                            strokeWidth: 8,
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Current Streak'),
                      const Text('0 days', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            
            // Today's habits section
            Expanded(
              child: BlocBuilder<HabitBloc, HabitState>(
                builder: (context, state) {
                  if (state is HabitLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TodayHabitsLoaded) {
                    if (state.habits.isEmpty) {
                      return const Center(
                        child: Text('No habits for today. Add some habits to get started!'),
                      );
                    }
                    
                    return ListView.builder(
                      itemCount: state.habits.length,
                      itemBuilder: (context, index) {
                        final habit = state.habits[index];
                        return HabitListItem(
                          habit: habit,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HabitDetailPage(habit: habit),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is HabitError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('No habits found'));
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateHabitPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
