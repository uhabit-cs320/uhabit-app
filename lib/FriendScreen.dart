import 'package:flutter/material.dart';
import 'package:UHabit/models/friend.dart';
import 'package:UHabit/models/friend_request.dart';
import 'package:UHabit/services/friend/friend_service.dart';
import 'package:UHabit/services/friend/friend_service_impl.dart';
import 'FriendsListScreen.dart';
import 'package:UHabit/models/user_profile.dart';

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final FriendService _friendService = FriendServiceImpl();
  bool showFriendRequests = false;
  List<Friend> friends = [];
  List<UserProfile> suggestedFriends = [];
  List<FriendRequest> friendRequests = [];
  List<FriendRequest> outgoingFriendRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    try {
      final futures = await Future.wait([
        _friendService.getFriends(),
        _friendService.getSuggestedFriends(),
        _friendService.getIncomingFriendRequests(),
        _friendService.getOutgoingFriendRequests(),
      ]);
      
      setState(() {
        friends = futures[0] as List<Friend>;
        suggestedFriends = futures[1] as List<UserProfile>;
        friendRequests = futures[2] as List<FriendRequest>;
        outgoingFriendRequests = futures[3] as List<FriendRequest>;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading friends data: $e');
      setState(() => isLoading = false);
    }
  }

  void showSnackbar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.black)),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildFriendRequestsSection() {
    return Column(
      children: [
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
          ...friendRequests.where((request) => request.status == FriendRequestStatus.pending).map((request) => ListTile(
            leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: request.senderProfile?.photoUrl != null 
                    ? NetworkImage(request.senderProfile!.photoUrl!)
                    : null,
                ),
            title: Text(request.senderProfile?.name ?? 'Unknown'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: () async {
                    await _friendService.acceptFriendRequest(request.senderId.toString());
                    _loadData(); // Reload the data
                    showSnackbar(
                      context,
                      'Accepted friend request',
                      Colors.lightGreen,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () async {
                    await _friendService.rejectFriendRequest(request.senderId.toString());
                    _loadData(); // Reload the data
                    showSnackbar(
                      context,
                      'Rejected friend request',
                      Colors.redAccent,
                    );
                  },
                ),
              ],
            ),
          )).toList(),
        if (showFriendRequests) 
          ...outgoingFriendRequests.where((request) => request.status == FriendRequestStatus.pending || request.status == FriendRequestStatus.rejected).map((request) => ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: request.receiverProfile?.photoUrl != null 
              ? NetworkImage(request.receiverProfile!.photoUrl!)
              : null,
          ),
          title: Text(request.receiverProfile?.name ?? 'Unknown'),
          trailing: switch(request.status) {
            FriendRequestStatus.pending => IconButton(
              icon: Icon(Icons.cancel, color: Colors.red),
              onPressed: () async {
                await _friendService.cancelFriendRequest(request.receiverId.toString());
                _loadData();
              },
            ),
            FriendRequestStatus.rejected => Icon(Icons.close, color: Colors.grey, size: 24),
            _ => throw UnimplementedError(),
          },
          )).toList(),  
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
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
                    builder: (context) => FriendsListScreen(
                      friends: friends,
                    ),
                  ),
                );
              },
            ),

            _buildFriendRequestsSection(),

            // Suggested Users Gallery
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'People you may know',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: suggestedFriends.length,
              itemBuilder: (context, index) {
                final suggestedName = suggestedFriends[index].name;
                return Card(
                  elevation: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: suggestedFriends[index].photoUrl != null 
                          ? NetworkImage(suggestedFriends[index].photoUrl!)
                          : null,
                      ),
                      SizedBox(height: 6),
                      Text(
                        suggestedName ?? '',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2),
                      ElevatedButton(
                        onPressed: () async {
                          final user = suggestedFriends[index];
                          await _friendService.sendFriendRequest(user.id);
                          _loadData();
                          showSnackbar(
                            context,
                            'Friend request sent to ${user.name}',
                            Colors.tealAccent,
                          );
                          setState(() {
                            suggestedFriends.removeAt(index);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreenAccent,
                        ),
                        child: Text('Add Friend',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
