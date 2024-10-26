import 'package:flutter/material.dart';

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
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.chat, color: Colors.black),
          onPressed: () {
            // Define the action for chat icon
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.black),
          onPressed: () {
            // Define the action for notifications icon
          },
        ),
        IconButton(
          icon: Icon(Icons.settings, color: Colors.black),
          onPressed: () {
            // Define the action for settings icon
          },
        ),
      ],
      iconTheme: IconThemeData(color: Colors.black), // Color for any leading icons
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
