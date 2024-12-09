import 'package:flutter/material.dart';

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
              title: Text('Friend Request!'),
              subtitle: Text('Gordon Ramsay sent you a friend request'),
            ),
            ListTile(
              title: Text('Request accepted!'),
              subtitle: Text('You are now friend with Mr. Treehari'),
            ),
            ListTile(
              title: Text('Friend Request!'),
              subtitle: Text('Ronaldo Nazario sent you a friend request!'),
            ),
            ListTile(
              title: Text('New challenge!'),
              subtitle: Text('Trung Dang has challenged you to a new habit: Drinking Water!'),
            ),
            // Add more notifications as needed
          ],
        ),
      ),
    );
  }
}
