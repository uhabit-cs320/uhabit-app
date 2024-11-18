import 'package:flutter/material.dart';
import 'AppBar.dart';

class FriendProfileScreen extends StatefulWidget {
  final Map<String, dynamic> friendData;

  FriendProfileScreen({required this.friendData});

  @override
  _FriendProfileScreenState createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  late Map<String, bool> followStatus;

  @override
  void initState() {
    super.initState();
    // Initialize the follow status for each habit as false (not followed)
    followStatus = {
      for (var habit in widget.friendData['habits']) habit: false,
    };
  }

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Scaffold(
      appBar: CustomAppBar(title:"Friend's Profile"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Friend's Avatar and Bio
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.friendData['name'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.friendData['bio'],
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Calendar Section
            Text(
              'Activity Calendar - November 2024',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),

            // Days of the Week
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: daysOfWeek
                  .map((day) => Text(
                day,
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
                  .toList(),
            ),
            SizedBox(height: 5),

            // Calendar Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.check_circle,
                    color: widget.friendData['calendar'][index]
                        ? Colors.green
                        : Colors.grey[300],
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // List of Habits with Follow/Unfollow Buttons
            Text(
              'Habits',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.friendData['habits'].length,
                itemBuilder: (context, index) {
                  final habit = widget.friendData['habits'][index];
                  final isFollowed = followStatus[habit] ?? false;

                  return ListTile(
                    title: Text(
                      habit,
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isFollowed ? Colors.white : Colors.lightGreenAccent,
                        side: isFollowed
                            ? BorderSide(color: Colors.lightGreenAccent)
                            : null,
                      ),
                      onPressed: () {
                        setState(() {
                          followStatus[habit] = !isFollowed;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFollowed
                                  ? 'Unfollowed $habit'
                                  : 'Followed $habit',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        isFollowed ? 'Unfollow' : 'Follow',
                        style: TextStyle(
                          color: isFollowed
                              ? Colors.lightGreenAccent
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
