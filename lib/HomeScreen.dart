import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        habits.add({
          'name': name,
          'days': List.generate(7, (_) => false),
          'icon': Icons.star, // Default icon
        });
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
                  _buildHabitTracker(),
                  const SizedBox(height: 24),
                  _buildChallengesSection(),
                  const SizedBox(height: 24),
                  _buildPostsSection(),
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

  Widget _buildHabitTracker() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today is Wednesday',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            // Days of week header
            Row(
              children: [
                const SizedBox(width: 100), // Space for habit name
                ...List.generate(7, (index) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        weekDays[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 8),
            // Habit rows
            ...habits.map((habit) => _buildHabitRow(habit)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitRow(Map<String, dynamic> habit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Row(
              children: [
                Icon(habit['icon'], color: Colors.green[400]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    habit['name'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(
            7,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    habit['days'][index] = !habit['days'][index];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color:
                        habit['days'][index] ? Colors.green[400] : Colors.white,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: habit['days'][index]
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add Habit Button
  Widget _buildAddHabitButton() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Habit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Habit Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('#/week'),
                const SizedBox(width: 16),
                const Text('Alert'),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Color: Stuff (Feature)'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add Habit'),
            ),
          ],
        ),
      ),
    );
  }

// Keep the existing methods for challenges and posts sections
  Widget _buildChallengesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggested Habits',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Make accountability a little easier ;D',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        _buildChallengeCard(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildChallengeCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Stay Hydrated',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[400],
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Join Habit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // New Method to Build the Posts Section
  Widget _buildPostsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'For You',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...posts.map((post) => _buildPostCard(post)).toList(),
      ],
    );
  }

  // New Method to Build Individual Post Cards
  Widget _buildPostCard(Map<String, String> post) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['name']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              post['message']!,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              post['date']!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
