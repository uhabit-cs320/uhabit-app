import 'package:flutter/material.dart';
import 'AppBar.dart';

class FriendsListScreen extends StatelessWidget {
  final List<Map<String, String>> friends;

  FriendsListScreen({required this.friends});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:"My Friends"),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return ListTile(
            leading: Icon(
              Icons.person,
              size: 40,
              color: Colors.grey,
            ),
            title: Text(
              friend['name']!,
              style: TextStyle(fontSize: 18),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          );
        },
      ),
    );
  }
}
