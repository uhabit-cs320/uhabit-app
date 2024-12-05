import 'package:UHabit/models/user_profile.dart';
import 'package:UHabit/services/habit/habit_record_service.dart';
import 'package:UHabit/services/habit/habit_record_service_impl.dart';
import 'package:UHabit/services/habit/habit_service.dart';
import 'package:flutter/material.dart';
import 'package:UHabit/models/habit.dart';
import 'package:UHabit/models/habit_record.dart';
import 'package:UHabit/services/habit/habit_service_impl.dart';
import 'AppBar.dart';
import 'package:intl/intl.dart';

class FriendProfileScreen extends StatefulWidget {
  final UserProfile friendData;

  FriendProfileScreen({required this.friendData});

  @override
  _FriendProfileScreenState createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  final HabitService _habitService = HabitServiceImpl();
  final HabitRecordService _habitRecordService = HabitRecordServiceImpl();
  Map<int, bool> followStatus = {};
  List<HabitRecord> _activeHabits = [];
  List<Habit> _friendHabits = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    try {
      final activeHabits = await _habitRecordService.getActiveHabits();
      
      // Get the friend's habits using their ID
      final publicHabits = await _habitService.getPublicHabits();
      final friendHabits = await Future.wait(
        publicHabits.map(
          (habit) async => await _habitService.getHabit(habit.id)
        ).toList()
      );
      
      setState(() {
        _activeHabits = activeHabits;
        _friendHabits = friendHabits.where((habit) => habit != null).cast<Habit>().toList();
        // Initialize follow status based on whether we have the same habit
        followStatus = {
          for (var habit in _friendHabits)
            habit.id: _activeHabits.any((h) => h.habitId == habit.id)
        };
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading habits: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleHabitFollow(int habitId) async {
    try {
      final isCurrentlyFollowed = followStatus[habitId] ?? false;
      
      if (!isCurrentlyFollowed) {
        // Follow the habit
        final result = await _habitService.submitHabitRecord(habitId);
        if (result != null) {
          setState(() {
            followStatus[habitId] = true;
          });
        }
      }
      // Note: Unfollowing functionality would need to be implemented in the backend
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isCurrentlyFollowed
                ? 'Unfollowed habit'
                : 'Started following habit',
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error toggling habit: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating habit'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Friend's Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Friend's Avatar and Bio
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.friendData.name ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.friendData.bio ?? '',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Calendar Section
              Text(
                'Activity Calendar - ${DateFormat('MMMM yyyy').format(DateTime.now())}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),

              // Days of the Week
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                    .map((day) => Text(
                          day,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                    .toList(),
              ),
              SizedBox(height: 5),

              // Calendar Grid
              Container(
                height: 300, // Fixed height for the calendar grid
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(), // Prevent grid scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 42, // 6 weeks × 7 days
                  itemBuilder: (context, index) {
                    final firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
                    final startingWeekday = firstDayOfMonth.weekday % 7;
                    final adjustedIndex = index - startingWeekday;
                    final currentDate = firstDayOfMonth.add(Duration(days: adjustedIndex));
                    
                    // Check if the date is within the current month
                    final isCurrentMonth = currentDate.month == DateTime.now().month;
                    
                    // Check if this date has completed habits
                    final isCompleted = _activeHabits.any(
                      (habit) => habit.completedDates.contains(
                        DateFormat('yyyy-MM-dd').format(currentDate)
                      )
                    );

                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isCurrentMonth 
                            ? Colors.transparent
                            : isCompleted
                                ? Colors.green[400]
                                : Colors.grey[200],
                      ),
                      child: isCurrentMonth
                          ? Center(
                              child: isCompleted
                                  ? Icon(Icons.check, color: Colors.white, size: 16)
                                  : Text(
                                      '${currentDate.day}',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                      ),
                                    ),
                            )
                          : null,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // List of Habits
              Text(
                'Habits',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              _isLoading 
                ? Center(child: CircularProgressIndicator()) 
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _friendHabits.length,
                    itemBuilder: (context, index) {
                      final habit = _friendHabits[index];
                      final isFollowed = followStatus[habit.id] ?? false;

                      return ListTile(
                        title: Text(
                          habit.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isFollowed ? Colors.white : Colors.lightGreenAccent,
                            side: isFollowed
                                ? BorderSide(color: Colors.lightGreenAccent)
                                : null,
                          ),
                          onPressed: () => _toggleHabitFollow(habit.id),
                          child: Text(
                            isFollowed ? 'Unfollow' : 'Follow',
                            style: TextStyle(
                              color: isFollowed
                                  ? Colors.lightGreenAccent
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
