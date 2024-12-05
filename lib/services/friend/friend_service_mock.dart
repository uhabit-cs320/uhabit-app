// lib/services/friend/mock_friend_service.dart
import 'package:UHabit/models/friend.dart';
import 'package:UHabit/models/user_profile.dart';
import 'package:UHabit/services/friend/friend_service.dart';
import 'package:UHabit/models/friend_request.dart';

class MockFriendService implements FriendService {
  final List<Friend> _friends = [
    Friend(id: '1', name: 'Trung Dang', email: 'test@gmail.com'),
    Friend(id: '2', name: 'Joe Lebedev', email: 'test@gmail.com'),
    Friend(id: '3', name: 'Zachary Tobey', email: 'test@gmail.com'),
    Friend(id: '4', name: 'Shanyu Thibaut Juneja', email: 'test@gmail.com'),
    Friend(id: '5', name: 'Mr. Treehari', email: 'test@gmail.com'),
  ];

  final List<FriendRequest> _friendRequests = [
    FriendRequest(id: 1, senderId: 1, receiverId: 2, date: DateTime.now(), status: 'pending'),
    FriendRequest(id: 2, senderId: 3, receiverId: 4, date: DateTime.now(), status: 'pending'),
  ];

  final List<String> _suggestedFriends = [
    'Alan Walker',
    'Aunt Angelina',
    'Uncle Brad',
    'William Smith',
    'Taylor Swift',
    'Travis Scott'
  ];

  @override
  Future<List<Friend>> getFriends() async {
    return _friends;
  }

  @override
  Future<bool> isFriend(String friendId) async {
    return _friends.any((friend) => friend.id == friendId);
  }

  @override
  Future<void> removeFriend(String friendId) async {
    _friends.removeWhere((friend) => friend.id == friendId);
  }

  @override
  Future<List<UserProfile>> getSuggestedFriends() async {
    return _suggestedFriends.map((name) => UserProfile(
      id: name,
      name: name,
      email: name,
      bio: '',
      habits: {},
    )).toList();
  }
}