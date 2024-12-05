import 'package:flutter/material.dart';
import 'AppBar.dart';
import 'FriendProfileScreen.dart';
import 'package:UHabit/models/friend.dart';

class FriendsListScreen extends StatelessWidget {
  final List<Friend> friends;

  FriendsListScreen({required this.friends});

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
              backgroundImage: friend.friendProfile?.photoUrl != null
                  ? NetworkImage(friend.friendProfile!.photoUrl!) 
                  : null,
              backgroundColor: Colors.grey[300],
              child: friend.friendProfile?.photoUrl == null
                  ? Icon(Icons.person, color: Colors.grey)
                  : null,
            ),
            title: Text(friend.friendProfile?.name ?? 'Unknown Friend'),
            subtitle: Text(friend.friendProfile?.bio ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendProfileScreen(
                    friendData: {
                      'name': friend.friendProfile?.name ?? 'Unknown Friend',
                      'bio': friend.friendProfile?.bio ?? '',
                      'habits': friend.friendProfile?.habits?.keys.toList() ?? [],
                      'calendar': List.generate(30, (index) => false), // Default calendar
                    },
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
