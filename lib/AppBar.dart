import 'package:flutter/material.dart';
// Import the SettingsScreen
import 'NotificationScreen.dart'; // Import the NotificationScreen

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.green[400]),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
        ),
      ],
      iconTheme: IconThemeData(color: Colors.green[400]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
