import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  final String userName;
  final String userImage;
  final String bio;
  final Map<String, int> habits;

  UserScreen({
    this.userName = 'We Are Group 7',
    this.userImage = 'https://re-mm-assets.s3.amazonaws.com/product_photo/20404/large_Poly_LightPink_7422up_1471501981.jpg', // Placeholder image URL
    this.bio = 'This is the user bio that describes the user’s interests and activities.',
    Map<String, int>? habits, // Make habits nullable
  }) : this.habits = habits ?? const {
    'Exercise': 5,
    'Reading': 3,
    'Meditation': 7,
    'Cooking': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User image
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(userImage),
            ),
            SizedBox(height: 16),

            // User name
            Text(
              userName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Username
            Text(
              '@asktehdevs',
              style: TextStyle(fontSize: 16, color: Colors.lightBlueAccent),
            ),
            SizedBox(height: 16),

            // User bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 24),

            // List of habits
            Text(
              'Habits',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: habits.entries.map((entry) {
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text('${entry.value} days',
                        style: TextStyle(fontSize: 15, color: Colors.lightGreen)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
