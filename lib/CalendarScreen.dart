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
  final Set<int> _completedDays = {
    1,
    2,
    3,
    4,
    7,
    8,
    9,
    10,
    11,
    12,
    15,
    16,
    18,
    19,
    21,
    22
  };

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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    final daysInMonth = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month + 1, 0).day;
    final firstDayOfMonth = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, 1);
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7),
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
}
