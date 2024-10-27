import 'package:flutter/material.dart';
import 'AppBar.dart';
class AddRecordScreen extends StatelessWidget {
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController elevationGainController = TextEditingController();

  // Sample list of habits
  final List<String> habits = [
    'Running',
    'Cycling',
    'Swimming',
    'Yoga',
    'Strength Training',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:"Record Activity"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Habits List
            Text(
              'Select Habits:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(habits[index]),
                    onTap: () {
                      _showConfirmationDialog(context, habits[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String habitName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hold on!', style: TextStyle(fontSize: 18)),
          content: Text('Are you done with $habitName for today?'),
          actions: [
            TextButton(
              child: Text('Confirm', style: TextStyle(color: Colors.green)),
              onPressed: () {
                // Handle confirmation logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
