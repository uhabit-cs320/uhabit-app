// lib/services/friend/mock_friend_service.dart
import 'package:UHabit/models/friend.dart';
import 'package:UHabit/models/user_profile.dart';
import 'package:UHabit/services/friend/friend_service.dart';
import 'package:UHabit/models/friend_request.dart';

class MockFriendService implements FriendService {
  final List<Friend> _friends = [
    Friend(id: 1, userId: 1, friendId: 2, status: FriendStatus.friend, createdDate: DateTime.now(), updatedDate: DateTime.now()),
    Friend(id: 2, userId: 1, friendId: 3, status: FriendStatus.friend, createdDate: DateTime.now(), updatedDate: DateTime.now()),
    Friend(id: 3, userId: 1, friendId: 4, status: FriendStatus.friend, createdDate: DateTime.now(), updatedDate: DateTime.now()),
    Friend(id: 4, userId: 1, friendId: 5, status: FriendStatus.friend, createdDate: DateTime.now(), updatedDate: DateTime.now()),
    Friend(id: 5, userId: 1, friendId: 6, status: FriendStatus.friend, createdDate: DateTime.now(), updatedDate: DateTime.now()),
  ];

  final List<FriendRequest> _friendRequests = [
    FriendRequest(id: 1, senderId: 1, receiverId: 2, date: DateTime.now(), status: FriendRequestStatus.pending),
    FriendRequest(id: 2, senderId: 3, receiverId: 4, date: DateTime.now(), status: FriendRequestStatus.pending),
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

  @override
  Future<void> acceptFriendRequest(String friendRequestId) async {
    _friendRequests.removeWhere((request) => request.id == friendRequestId);
  }

  @override
  Future<void> cancelFriendRequest(String friendRequestId) async {
    _friendRequests.removeWhere((request) => request.id == friendRequestId);
  }

  @override
  Future<void> rejectFriendRequest(String friendRequestId) async {
    _friendRequests.removeWhere((request) => request.id == friendRequestId);
  }

  @override
  Future<List<FriendRequest>> getIncomingFriendRequests() async {
    return _friendRequests.where((request) => request.receiverId == 1).toList();
  }

  @override
  Future<List<FriendRequest>> getOutgoingFriendRequests() async {
    return _friendRequests.where((request) => request.senderId == 1).toList();
  }

  @override
  Future<void> sendFriendRequest(String friendId) async {
    _friendRequests.add(FriendRequest(id: _friendRequests.length + 1, senderId: 1, receiverId: int.parse(friendId), date: DateTime.now(), status: FriendRequestStatus.pending));
  }
}
