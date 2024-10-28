import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//hi

class _HomeScreenState extends State<HomeScreen> {
  // Sample habit data to change later.
  final List<Map<String, dynamic>> habits = [
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

  final List<Map<String, String>> posts = [
    {
      'name': 'Alice Johnson',
      'message': 'Just completed a 5km run today! Feeling great!',
      'date': '2 hours ago',
    },
    {
      'name': 'Bob Smith',
      'message':
      'Achieved a new personal best for my streak! 30 days in a row!',
      'date': '3 hours ago',
    },
    {
      'name': 'Charlie Brown',
      'message': 'Finished reading 2 books this week! Loving it!',
      'date': '5 hours ago',
    },
    {
      'name': 'Diana Prince',
      'message': 'Drank 3 liters of water today! Staying hydrated!',
      'date': '1 day ago',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                const SizedBox(width: 80), // Space for habit name
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
            width: 80,
            child: Row(
              children: [
                Icon(habit['icon']),
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
                    color: habit['days'][index] ? Colors.green : Colors.white,
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
                backgroundColor: Colors.green,
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
          'Suggested Challenges',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Make accountability a little easier and much more fun!',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        _buildChallengeCard(),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Explore All Challenges',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
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
                        'WHO x Awkafina: Stay Hyrdated',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2 liters a day keeps the doctor away',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Digital Trophy',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'More than 73,000 athletes have already joined',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Join Challenge',
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
