import 'package:flutter/material.dart';
import 'SettingsScreen.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Notification 1'),
              subtitle: Text('You have a new message.'),
            ),
            ListTile(
              title: Text('Notification 2'),
              subtitle: Text('Your friend has sent a friend request.'),
            ),
            ListTile(
              title: Text('Notification 3'),
              subtitle: Text('You completed your workout!'),
            ),
            // Add more notifications as needed
          ],
        ),
      ),
    );
  }
}
