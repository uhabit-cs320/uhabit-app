import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateFormat _dateFormat = DateFormat('MMM d, yyyy');
  final DateFormat _monthFormat = DateFormat('MMMM yyyy');

  // Completed days for the current month
  final Set<int> _completedDays = {1,2,3,4,7, 8, 9, 10, 11, 12, 15, 16, 18, 19, 21, 22};

  // Hardcoded streaks for top 10
  final List<DateTimeRange> _completedRanges = [
    DateTimeRange(start: DateTime(2023, 10, 1), end: DateTime(2023, 10, 5)),
    DateTimeRange(start: DateTime(2023, 11, 3), end: DateTime(2023, 11, 8)),
    DateTimeRange(start: DateTime(2023, 12, 15), end: DateTime(2023, 12, 22)),
    DateTimeRange(start: DateTime(2024, 1, 7), end: DateTime(2024, 1, 10)),
    DateTimeRange(start: DateTime(2024, 2, 2), end: DateTime(2024, 2, 9)),
    DateTimeRange(start: DateTime(2024, 3, 5), end: DateTime(2024, 3, 11)),
    DateTimeRange(start: DateTime(2024, 4, 12), end: DateTime(2024, 4, 17)),
    DateTimeRange(start: DateTime(2024, 5, 20), end: DateTime(2024, 5, 27)),
    DateTimeRange(start: DateTime(2024, 6, 1), end: DateTime(2024, 6, 6)),
    DateTimeRange(start: DateTime(2024, 7, 10), end: DateTime(2024, 7, 15)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _monthFormat.format(DateTime.now()),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildCalendar(),
              SizedBox(height: 30),
              Text(
                "Top 10 Best Streaks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildStreaks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    final daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    final firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    final daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: daysOfWeek.map((day) => Text(day)).toList(),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: daysInMonth + firstDayOfMonth.weekday,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
          itemBuilder: (context, index) {
            if (index < firstDayOfMonth.weekday) {
              return SizedBox(); // Empty space for days before the current month starts
            } else {
              final day = index - firstDayOfMonth.weekday + 1;
              return Center(
                child: _completedDays.contains(day)
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Text(day.toString()),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildStreaks() {
    // Sort streaks by start date for chronological display
    List<Streak> streaks = _completedRanges.map((range) => Streak(range.start, range.end)).toList();
    streaks.sort((a, b) => a.start.compareTo(b.start));

    // Sort streaks by length for color ranking
    List<Streak> streaksByLength = List.from(streaks);
    streaksByLength.sort((a, b) => b.length.compareTo(a.length));

    // Create a map of streak to its color rank based on length
    Map<Streak, Color> streakColors = {};
    for (int i = 0; i < streaksByLength.length; i++) {
      double colorFactor = (streaksByLength.length - i) / streaksByLength.length;
      streakColors[streaksByLength[i]] = Color.lerp(Colors.grey, Colors.lightGreen, colorFactor)!;
    }

    // Get the maximum length to scale bar width proportionally
    int maxStreakLength = streaksByLength[0].length;

    return Column(
      children: streaks.take(10).map((streak) {
        int rank = streaksByLength.indexOf(streak); // Use the rank based on length
        return _buildStreakRow(streak, streakColors[streak]!, maxStreakLength);
      }).toList(),
    );
  }

  Widget _buildStreakRow(Streak streak, Color color, int maxStreakLength) {
    // Calculate bar width factor based on the streak's length relative to the longest streak
    double barWidthFactor = (streak.length / maxStreakLength);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _dateFormat.format(streak.start),
            style: TextStyle(fontSize: 14),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              height: 10,
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: barWidthFactor,
                child: Container(
                  color: color,
                ),
              ),
            ),
          ),
          Text(
            _dateFormat.format(streak.end),
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class Streak {
  final DateTime start;
  final DateTime end;

  Streak(this.start, this.end);

  int get length => end.difference(start).inDays + 1;
}
