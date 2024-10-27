import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Account Settings'),
              onTap: () {
                // Handle account settings tap
              },
            ),
            ListTile(
              title: Text('Privacy Settings'),
              onTap: () {
                // Handle privacy settings tap
              },
            ),
            ListTile(
              title: Text('Notifications'),
              onTap: () {
                // Handle notifications settings tap
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                // Handle about tap
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Handle logout tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
