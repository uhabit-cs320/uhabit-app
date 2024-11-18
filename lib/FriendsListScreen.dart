import 'package:flutter/material.dart';
import 'AppBar.dart';
import 'FriendProfileScreen.dart';

class FriendsListScreen extends StatelessWidget {
  final List<Map<String, String>> friends;

  FriendsListScreen({required this.friends});
  final Map<String, Map<String, dynamic>> friendsData = {
    'Trung Dang': {
      'name': 'Trung Dang',
      'bio': 'Night Owl',
      'habits': ['Soccer', 'Swimming', 'Drinking Water'],
      'calendar': List.generate(30, (index) => index % 7 == 0 || index % 3 == 2)
    },
    'Joe Lebedev': {
      'name': 'Joe Lebedev',
      'bio': 'Grinding research thesis',
      'habits': ['Biking', 'Running'],
      'calendar': List.generate(30, (index) => index % 3 == 1 || index % 4 == 2),
      // Random activity
    },
    'Zachary Tobey': {
      'name': 'Zachary Tobey',
      'bio': 'Enjoys hiking and reading',
      'habits': ['Running', 'Cooking', 'Meditation'],
      'calendar': List.generate(30, (index) => index % 2 == 0 || index % 7 == 3),
      // Random activity
    },
    'Shanyu Thibaut Juneja': {
      'name': 'Shanyu Thibaut Juneja',
      'bio': 'Tech enthusiast and coffee lover',
      'habits': ['Yoga', 'Journaling', 'Photography'],
      'calendar': List.generate(30, (index) => index % 3 == 0),
    },
    'Mr. Treehari': {
      'name': 'Mr. Treehari',
      'bio': 'adorable boss',
      'habits': ['Keeping Track of Team 7'],
      'calendar': List.generate(30, (index) => index % 1 == 0)
    },
    'Gordon Ramsay': {
      'name': 'Gordon Ramsay',
      'bio': 'I have 17 Michelin stars',
      'habits': ['filming', 'cooking', 'writing'],
      'calendar': List.generate(30, (index) => index % 7 == 6 || index % 5 == 2 || index % 4 == 1)
    }
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Friends"),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.grey),
            ),
            title: Text(friend['name']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendProfileScreen(
                    friendData: friendsData[friend['name']] as Map<String, dynamic>,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
