import 'package:UHabit/models/habit.dart';
import 'package:UHabit/models/habit_record.dart';
import 'package:UHabit/services/habit_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final HabitService _habitService = HabitService();
  List<HabitRecord> _habitRecords = [];
  Map<int, Habit> _habits = {};
  bool _isLoading = true;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    try {
      setState(() => _isLoading = true);
      print("Loading habits");
      final habits = await _habitService.getActiveHabits();
      setState(() {
        _habitRecords = habits;
        _isLoading = false;
      });

      // Load public habits
      print("Loading public habits");
      // Load habits
      final publicHabits = await _habitService.getPublicHabits();
      print("Public habits: ${publicHabits.map((habit) => habit.toJson()).join('\n')}");
      setState(() {
        _habits = {for (var habit in publicHabits) habit.id: habit};
      }); 

      print("Public habits: ${_habits.values.map((habit) => habit.toJson()).join('\n')}");

      // Load all private habits based on ids
      _habitRecords.forEach((habitTracker) async {
        if (!_habits.containsKey(habitTracker.habitId)) {
          final habit = await _habitService.getHabit(habitTracker.habitId);
          if (habit != null) {
            print("Adding habit: ${habit.name}");
            _habits[habit.id] = habit;
          }
        }
      });

      // Print the habits in a readable format
      print("Habits: ${_habitRecords.map((habit) => habit.toJson()).join('\n')}");
      print("Habits length: ${_habitRecords.length}");

    } catch (e) {
      print('Error loading habits: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleHabit(int habitId) async {
    try {
      final updatedRecord = await _habitService.submitHabitRecord(habitId);
      if (updatedRecord != null) {
        setState(() {
          final index = _habitRecords.indexWhere((record) => record.habitId == habitId);
          if (index != -1) {
            _habitRecords[index] = updatedRecord;
          }
        });
      }
    } catch (e) {
      print('Error toggling habit: $e');
    }
  }

  // Sample habit data to change later.
  List<Map<String, dynamic>> habits = [
    {
      'name': 'Workout',
      'days': [true, false, true, false, false, false, false],
      'icon': Icons.fitness_center,
    },
    {
      'name': 'Brush Teeth',
      'days': [true, false, false, false, false, false, false],
      'icon': Icons.bathroom,
    },
  ];

  final List<String> weekDays = ['M', 'T', 'W', 'Th', 'F', 'S', 'S'];
  final TextEditingController _habitNameController = TextEditingController();
  final List<Map<String, String>> posts = [
    {
      'name': 'Alice Johnson',
      'message': 'Completed running habit!',
      'date': '2 hours ago',
    },
    {
      'name': 'Bob Smith',
      'message': 'Achieved a habit streak of 30 days!',
      'date': '3 hours ago',
    },
    {
      'name': 'Charlie Brown',
      'message': 'Completed reading books habits 2 times this week!',
      'date': '5 hours ago',
    },
    {
      'name': 'Diana Prince',
      'message': 'Completed drink 3 liters of water habit!',
      'date': '1 day ago',
    },
  ];

  @override
  void dispose() {
    _habitNameController.dispose();
    super.dispose();
  }

  void _addNewHabit(String name) {
    if (name.isNotEmpty) {
      setState(() {
        final newHabit = {
          'name': name,
          'days': List.generate(7, (_) => false),
          'icon': Icons.star, // Default icon
        };
        habits.add(newHabit);
        _listKey.currentState?.insertItem(habits.length - 1);
      });
    }
  }

  Future<void> _showAddHabitDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Habit'),
          content: TextField(
            controller: _habitNameController,
            decoration: const InputDecoration(
              hintText: 'Enter habit name',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _habitNameController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addNewHabit(_habitNameController.text);
                Navigator.pop(context);
                _habitNameController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDailyHabits(),
                  const SizedBox(height: 24),
                  _buildStreaksSection(),
                  const SizedBox(height: 24),
                  _buildSocialFeed(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        backgroundColor: Colors.green[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDailyHabits() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      initialItemCount: _habitRecords.length,
      itemBuilder: (context, index, animation) {
        final record = _habitRecords[index];
        final habit = _habits[record.habitId];
        if (habit == null) return const SizedBox.shrink();

        final today = DateTime.now();
        final isCompletedToday = record.completedDates
            .any((date) => DateUtils.isSameDay(date, today));
        
        // Calculate streak
        int streak = 0;
        DateTime checkDate = today;
        while (record.completedDates.any((date) => 
          DateUtils.isSameDay(date, checkDate))) {
          streak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        }

        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => _toggleHabit(record.habitId),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Container(
                        key: ValueKey<bool>(isCompletedToday),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isCompletedToday ? Colors.green[400] : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompletedToday ? Icons.check : Icons.check_box_outline_blank,
                          color: isCompletedToday ? Colors.white : Colors.grey[400],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (streak > 0) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.local_fire_department, 
                                  color: Colors.orange[400],
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$streak day streak!',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStreaksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Streaks',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _habitRecords.map((record) {
              final habit = _habits[record.habitId];
              if (habit == null) return const SizedBox.shrink();

              // Calculate streak
              int streak = 0;
              DateTime checkDate = DateTime.now();
              while (record.completedDates.any((date) => 
                DateUtils.isSameDay(date, checkDate))) {
                streak++;
                checkDate = checkDate.subtract(const Duration(days: 1));
              }

              if (streak == 0) return const SizedBox.shrink();

              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange[400]!, Colors.red[400]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🔥',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      streak.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      habit.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Friend Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            post['name']![0],
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                post['date']!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      post['message']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: Icon(Icons.favorite_border, 
                            color: Colors.grey[600],
                            size: 18,
                          ),
                          label: Text(
                            'Cheer',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          onPressed: () {
                            // Implement cheer functionality
                          },
                        ),
                      ],
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
}
