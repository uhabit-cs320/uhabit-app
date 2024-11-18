import 'package:flutter/material.dart';
import 'FriendsListScreen.dart';

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  bool showFriendRequests = false;

  List<String> friendRequests = ['Gordon Ramsay', 'Ronaldo Nazario'];
  List<Map<String, String>> suggestedUsers = [
    {'name': 'Alan Walker'},
    {'name': 'Aunt Angelina'},
    {'name': 'Uncle Brad'},
    {'name': 'William Smith'},
    {'name': 'Taylor Swift'},
    {'name': 'Travis Scott'}
  ];

  List<Map<String, String>> friends = [
    {'name': 'Trung Dang'},
    {'name': 'Joe Lebedev'},
    {'name': 'Zachary Tobey'},
    {'name': 'Shanyu Thibaut Juneja'},
    {'name': 'Mr. Treehari'}
  ];

  void showSnackbar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigate to My Friends list
          ListTile(
            title: Text(
              'My Friends',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendsListScreen(friends: friends),
                ),
              );
            },
          ),

          // Friend Requests section
          ListTile(
            title: Text(
              'Friend Requests',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              showFriendRequests ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
            onTap: () {
              setState(() {
                showFriendRequests = !showFriendRequests;
              });
            },
          ),
          if (showFriendRequests)
            Column(
              children: friendRequests
                  .map((request) => ListTile(
                title: Text(request),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          // Add the accepted friend to the friends list
                          friends.add({'name': request});
                          // Remove from friend requests
                          friendRequests.remove(request);
                        });
                        showSnackbar(
                          context,
                          'Accepted friend request',
                          Colors.lightGreen,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          friendRequests.remove(request);
                        });
                        showSnackbar(
                          context,
                          'Rejected friend request',
                          Colors.redAccent,
                        );
                      },
                    ),
                  ],
                ),
              ))
                  .toList(),
            ),

          // Suggested Users Gallery
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'People you may know',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: suggestedUsers.length,
              itemBuilder: (context, index) {
                final user = suggestedUsers[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(height: 8),
                      Text(
                        user['name']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            suggestedUsers.removeAt(index);
                          });
                          showSnackbar(
                            context,
                            'Friend request sent to ${user['name']}',
                            Colors.tealAccent,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent, // Background color
                        ),
                        child: Text('Add Friend',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
