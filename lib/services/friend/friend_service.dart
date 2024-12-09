import 'package:UHabit/models/friend.dart';
import 'package:UHabit/models/user_profile.dart';
import 'package:UHabit/models/friend_request.dart';

abstract class FriendService {
  Future<List<Friend>> getFriends();
  Future<void> removeFriend(String friendId);
  Future<bool> isFriend(String friendId);
  Future<List<UserProfile>> getSuggestedFriends();
  Future<List<UserProfile>> searchFriends(String query);
  
  // New methods for friend requests
  Future<List<FriendRequest>> getIncomingFriendRequests();
  Future<List<FriendRequest>> getOutgoingFriendRequests();

  Future<void> sendFriendRequest(String targetId);
  Future<void> acceptFriendRequest(String senderId);
  Future<void> rejectFriendRequest(String senderId);
  Future<void> cancelFriendRequest(String targetId);
}